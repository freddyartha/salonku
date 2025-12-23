import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart' hide Response, MultipartFile, FormData;

import '../../../config/environment.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/device/device_info.dart';
import 'dio_client.dart';

abstract class ApiProvider {
  final Dio _dio = DioClient.instance;

  // ===== HEADER GETTERS =====

  /// Get Authorization headers (Bearer token)
  Future<Map<String, String>> getAuthHeaders() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final token = await user?.getIdToken();

      if (token != null && token.isNotEmpty) {
        return {ApiConstants.headerAuthorization: 'Bearer $token'};
      }
    } catch (e) {
      developer.log('Error getting auth headers: $e', name: 'API_PROVIDER');
    }
    return {};
  }

  /// Get device-specific headers
  Future<Map<String, String>> get deviceHeaders async {
    return {
      'X-Device-Platform': Platform.operatingSystem,
      'X-Device-Model': _getDeviceModel(),
      'X-Timezone': DateTime.now().timeZoneName,
      'X-Request-Time': DateTime.now().millisecondsSinceEpoch.toString(),
      'X-Device-Fingerprint': await DeviceInfo.getDeviceFingerprint(),
    };
  }

  /// Get base headers (always included)
  Map<String, String> get baseHeaders {
    return {
      ApiConstants.headerContentType: ApiConstants.contentTypeJson,
      ApiConstants.headerAccept: ApiConstants.accept,
    };
  }

  // ===== HTTP METHODS =====

  /// GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
    Duration? timeout,
  }) async {
    final requestHeaders = _buildHeaders(
      customHeaders: headers,
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
    );

    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: await requestHeaders,
        sendTimeout: timeout ?? EnvironmentConfig.sendTimeout,
        receiveTimeout: timeout ?? EnvironmentConfig.receiveTimeout,
      ),
      cancelToken: cancelToken ?? _createCancelToken(),
    );
  }

  /// POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
    Duration? timeout,
    ProgressCallback? onSendProgress,
  }) async {
    final requestHeaders = _buildHeaders(
      customHeaders: headers,
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
    );

    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: await requestHeaders,
        sendTimeout: timeout ?? EnvironmentConfig.sendTimeout,
        receiveTimeout: timeout ?? EnvironmentConfig.receiveTimeout,
      ),
      onSendProgress: onSendProgress,
      cancelToken: cancelToken ?? _createCancelToken(),
    );
  }

  /// PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
    Duration? timeout,
  }) async {
    final requestHeaders = _buildHeaders(
      customHeaders: headers,
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
    );

    return await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: await requestHeaders,
        sendTimeout: timeout ?? EnvironmentConfig.sendTimeout,
        receiveTimeout: timeout ?? EnvironmentConfig.receiveTimeout,
      ),
      cancelToken: cancelToken ?? _createCancelToken(),
    );
  }

  /// PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
    Duration? timeout,
  }) async {
    final requestHeaders = _buildHeaders(
      customHeaders: headers,
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
    );

    return await _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: await requestHeaders,
        sendTimeout: timeout ?? EnvironmentConfig.sendTimeout,
        receiveTimeout: timeout ?? EnvironmentConfig.receiveTimeout,
      ),
      cancelToken: cancelToken ?? _createCancelToken(),
    );
  }

  /// DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
    Duration? timeout,
  }) async {
    final requestHeaders = _buildHeaders(
      customHeaders: headers,
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
    );

    return await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: await requestHeaders,
        sendTimeout: timeout ?? EnvironmentConfig.sendTimeout,
        receiveTimeout: timeout ?? EnvironmentConfig.receiveTimeout,
      ),
      cancelToken: cancelToken ?? _createCancelToken(),
    );
  }

  // ===== FILE OPERATIONS =====

  /// Upload single file
  Future<Response> uploadFile(
    String path,
    File file, {
    String fieldName = 'file',
    Map<String, dynamic>? additionalData,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
    Duration? timeout,
  }) async {
    // Validate file
    _validateFile(file);

    final fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      fieldName: await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        // contentType: MediaType.parse(_getMimeType(fileName)),
      ),
      if (additionalData != null) ...additionalData,
    });

    final requestHeaders = _buildHeaders(
      customHeaders: {
        ApiConstants.headerContentType: 'multipart/form-data',
        if (headers != null) ...headers,
      },
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
    );

    return await _dio.post(
      path,
      data: formData,
      options: Options(
        headers: await requestHeaders,
        sendTimeout: timeout ?? Duration(minutes: 5),
        receiveTimeout: timeout ?? Duration(minutes: 5),
      ),
      onSendProgress: onSendProgress,
      cancelToken: cancelToken ?? _createCancelToken(),
    );
  }

  /// Upload multiple files
  Future<Response> uploadMultipleFiles(
    String path,
    List<File> files, {
    String fieldName = 'files',
    Map<String, dynamic>? additionalData,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
    Duration? timeout,
  }) async {
    // Validate files
    for (final file in files) {
      _validateFile(file);
    }

    final formData = FormData();

    // Add files
    for (int i = 0; i < files.length; i++) {
      final file = files[i];
      final fileName = file.path.split('/').last;

      formData.files.add(
        MapEntry(
          '$fieldName[$i]',
          await MultipartFile.fromFile(
            file.path,
            filename: fileName,
            // contentType: MediaType.parse(_getMimeType(fileName)),
          ),
        ),
      );
    }

    // Add additional data
    if (additionalData != null) {
      additionalData.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }

    final requestHeaders = _buildHeaders(
      customHeaders: {
        ApiConstants.headerContentType: 'multipart/form-data',
        if (headers != null) ...headers,
      },
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
    );

    return await _dio.post(
      path,
      data: formData,
      options: Options(
        headers: await requestHeaders,
        sendTimeout: timeout ?? Duration(minutes: 10),
        receiveTimeout: timeout ?? Duration(minutes: 10),
      ),
      onSendProgress: onSendProgress,
      cancelToken: cancelToken ?? _createCancelToken(),
    );
  }

  /// Download file
  Future<Response> downloadFile(
    String path,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
    Duration? timeout,
    ResponseType? responseType,
  }) async {
    final requestHeaders = _buildHeaders(
      customHeaders: headers,
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
    );

    return await _dio.download(
      path,
      savePath,
      queryParameters: queryParameters,
      options: Options(
        headers: await requestHeaders,
        receiveTimeout: timeout ?? Duration(minutes: 10),
        responseType: responseType,
      ),
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken ?? _createCancelToken(),
    );
  }

  // ===== CONVENIENCE METHODS =====

  /// GET request without authentication
  Future<Response> getPublic(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    Duration? timeout,
  }) async {
    return get(
      path,
      queryParameters: queryParameters,
      headers: headers,
      cancelToken: cancelToken,
      requiresAuth: false,
      includeFirebaseToken: false,
      timeout: timeout,
    );
  }

  /// POST request without authentication
  Future<Response> postPublic(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    Duration? timeout,
    ProgressCallback? onSendProgress,
  }) async {
    return post(
      path,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
      cancelToken: cancelToken,
      requiresAuth: false,
      includeFirebaseToken: false,
      timeout: timeout,
      onSendProgress: onSendProgress,
    );
  }

  /// Paginated GET request
  Future<Response> getPaginated(
    String path, {
    int? page,
    int? limit,
    Map<String, dynamic>? additionalParams,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
  }) async {
    final queryParams = {
      'page': page ?? AppConstants.initPageNumber,
      'limit': limit ?? AppConstants.maxPerPageSize,
      if (additionalParams != null) ...additionalParams,
    };

    return get(
      path,
      queryParameters: queryParams,
      headers: headers,
      cancelToken: cancelToken,
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
    );
  }

  /// Search request
  Future<Response> search(
    String path,
    String query, {
    Map<String, dynamic>? filters,
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
  }) async {
    final queryParams = {
      'q': query,
      'page': page,
      'limit': limit,
      if (filters != null) ...filters,
    };

    return get(
      path,
      queryParameters: queryParams,
      headers: headers,
      cancelToken: cancelToken,
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
    );
  }

  /// Request with custom timeout
  Future<Response> getWithTimeout(
    String path,
    Duration timeout, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
  }) async {
    return get(
      path,
      queryParameters: queryParameters,
      headers: headers,
      cancelToken: cancelToken,
      requiresAuth: requiresAuth,
      includeFirebaseToken: includeFirebaseToken,
      timeout: timeout,
    );
  }

  // ===== HELPER METHODS =====

  /// Build headers for request
  Future<Map<String, dynamic>> _buildHeaders({
    Map<String, dynamic>? customHeaders,
    bool requiresAuth = true,
    bool includeFirebaseToken = true,
  }) async {
    final resultDeviceHeaders = await deviceHeaders;
    final headers = <String, dynamic>{...baseHeaders, ...resultDeviceHeaders};

    // Add auth headers if required
    if (requiresAuth) {
      var result = await getAuthHeaders();
      headers.addAll(result);
    }

    // Add custom headers (override existing)
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    return headers;
  }

  /// Create cancel token with automatic cleanup
  CancelToken _createCancelToken() {
    final cancelToken = CancelToken();

    // Auto cleanup after 5 minutes
    Timer(Duration(minutes: 5), () {
      if (!cancelToken.isCancelled) {
        cancelToken.cancel('Request timeout - auto cleanup');
      }
    });

    return cancelToken;
  }

  /// Validate file before upload
  void _validateFile(File file) {
    if (!file.existsSync()) {
      throw Exception('File does not exist: ${file.path}');
    }

    final fileSize = file.lengthSync();
    if (fileSize > AppConstants.maxFileSize) {
      throw Exception(
        'File too large: $fileSize bytes (max: ${AppConstants.maxFileSize})',
      );
    }

    final fileName = file.path.split('/').last;
    final extension = fileName.split('.').last.toLowerCase();

    final allowedExtensions = [
      ...AppConstants.allowedImageExtensions,
      ...AppConstants.allowedDocumentExtensions,
    ];

    if (!allowedExtensions.contains(extension)) {
      throw Exception('File type not allowed: $extension');
    }
  }

  /// Get device model (platform specific)
  String _getDeviceModel() {
    if (Platform.isAndroid) {
      return 'Android Device';
    } else if (Platform.isIOS) {
      return 'iOS Device';
    } else if (Platform.isWindows) {
      return 'Windows Device';
    } else if (Platform.isMacOS) {
      return 'macOS Device';
    } else if (Platform.isLinux) {
      return 'Linux Device';
    } else {
      return 'Unknown Device';
    }
  }
}
