import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../../../config/environment.dart';
import '../../../core/constants/api_constants.dart';
import '../../providers/network/interceptors/auth_interceptor.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio();

    // Base configuration
    dio.options = BaseOptions(
      baseUrl: EnvironmentConfig.hostUrl,
      connectTimeout: EnvironmentConfig.connectTimeout,
      receiveTimeout: EnvironmentConfig.receiveTimeout,
      sendTimeout: EnvironmentConfig.sendTimeout,
      headers: {
        ApiConstants.headerContentType: ApiConstants.contentTypeJson,
        ApiConstants.headerAccept: ApiConstants.accept,
      },
    );

    // Add interceptors
    dio.interceptors.addAll([
      AuthInterceptor(dio),
      if (EnvironmentConfig.enableLogging) _createLoggingInterceptor(),
    ]);

    return dio;
  }

  static LogInterceptor _createLoggingInterceptor() {
    return LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      logPrint: (object) {
        if (EnvironmentConfig.enableLogging) {
          developer.log(object.toString(), name: 'DIO');
        }
      },
    );
  }

  // Utility methods
  static void addInterceptor(Interceptor interceptor) {
    _dio?.interceptors.add(interceptor);
  }

  static void removeInterceptor(Interceptor interceptor) {
    _dio?.interceptors.remove(interceptor);
  }

  static void clearInterceptors() {
    _dio?.interceptors.clear();
  }

  static void recreate() {
    _dio = null;
    _dio = _createDio();
  }
}
