import 'dart:async';

import 'package:dio/dio.dart';
// import 'package:get/get.dart' as gt;

// import '../../../../core/constants/api_constants.dart';
// import '../../local/local_data_source.dart';
// import '../../local/local_data_source_impl.dart';

class AuthInterceptor extends Interceptor {
  // final Dio _dio;
  final List<PendingRequest> _pendingRequests = [];
  // bool _isRefreshing = false;

  // AuthInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final pendingRequest = PendingRequest(
      options: options,
      completer: Completer<Response>(),
    );

    _pendingRequests.add(pendingRequest);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _pendingRequests.removeWhere(
      (req) => req.options == response.requestOptions,
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // if (err.response?.statusCode == 401 &&
    //     !_isRefreshing &&
    //     err.requestOptions.headers.containsKey(
    //       ApiConstants.headerAuthorization,
    //     )) {
    //   _isRefreshing = true;

    //   try {
    //     await _cancelAllPendingRequests();

    //     await _checkInitializedLocalDataSource();

    //     // await _refreshToken();

    //     final retryResponse = await _retryRequest(err.requestOptions);
    //     handler.resolve(retryResponse);
    //   } catch (e) {
    //     handler.reject(err);
    //   } finally {
    //     _isRefreshing = false;
    //     _pendingRequests.clear();
    //   }
    // } else {
    handler.next(err);
    // }
  }

  // Future<void> _checkInitializedLocalDataSource() async {
  //   if (!gt.Get.isRegistered<LocalDataSource>()) {
  //     await gt.Get.putAsync<LocalDataSource>(() async => LocalDataSourceImpl());
  //   }
  // }

  // Future<void> _cancelAllPendingRequests() async {
  //   final requestsToCancel = List<PendingRequest>.from(_pendingRequests);

  //   for (final request in requestsToCancel) {
  //     if (request.options.cancelToken != null &&
  //         !request.options.cancelToken!.isCancelled) {
  //       request.options.cancelToken!.cancel(
  //         'Token expired, cancelling request',
  //       );
  //     }
  //   }

  //   await Future.delayed(Duration(milliseconds: 100));
  // }

  // Future<Response> _retryRequest(RequestOptions requestOptions) async {
  //   requestOptions.headers['Authorization'] = gt.Get.find<LocalDataSource>()
  //       .getAccessToken();

  //   return await _dio.fetch(requestOptions);
  // }

  // Future<Response> _refreshToken() async {
  //   try {
  //     final response = await _dio.post(
  //       ApiConstants.refreshToken,
  //       data: json.encode({
  //         "refresh_token": '',
  //         "fingerprint": await DeviceInfo.getDeviceFingerprint(),
  //       }),
  //     );

  //     final auth = AuthModel.fromJson(response.data["data"]);
  //     await gt.Get.find<LocalDataSource>().cacheAuth(auth);
  //     return response;
  //   } catch (err) {
  //     // await gt.Get.dialog(
  //     // SessionDialog(onPressed: () => gt.Get.back(closeOverlays: true)),
  //     // );
  //     await gt.Get.find<LocalDataSource>().clearAllCache();
  //     gt.Get.offAllNamed(Routes.LOGIN);
  //     rethrow;
  //   }
  // }
}

class PendingRequest {
  final RequestOptions options;
  final Completer<Response> completer;

  PendingRequest({required this.options, required this.completer});
}
