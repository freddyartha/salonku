import 'dart:ui';

import 'package:get/get.dart';
import 'package:mobile/app/services/error_handler_service.dart';

import '../../data/models/result.dart';

abstract class BaseController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<Error?> error = Rx<Error?>(null);

  Future<T?> handleRequest<T>(
    Future<Result<T>> Function() request, {
    bool showLoading = true,
    bool showErrorSnackbar = true,
    VoidCallback? onInit,
    Function(T data)? onSuccess,
    VoidCallback? onError,
    VoidCallback? onFinish,
  }) async {
    if (onInit != null) onInit();
    if (showLoading) isLoading.value = true;
    error.value = null;

    try {
      final result = await request();

      switch (result) {
        case Success<T> success:
          if (onSuccess != null) onSuccess(success.data);
          return success.data;

        case Error error:
          this.error.value = error;
          if (onError != null) onError();

          // Show error snackbar only if not already shown by BaseApiService
          if (showErrorSnackbar) {
            ErrorHandlerService.to.handleError(
              GeneralException(error.message ?? "Error Occured"),
            );
          }
          return null;

        case Cancelled<T> _:
          // Request was cancelled, don't show error
          return null;

        case Loading<T> _:
          // This shouldn't happen in this pattern
          return null;
      }
    } catch (e) {
      final message = 'Unexpected error: $e';
      error.value = Error(message);

      if (showErrorSnackbar) {
        ErrorHandlerService.to.handleError(GeneralException(message));
      }

      if (onError != null) onError();
      return null;
    } finally {
      if (showLoading) isLoading.value = false;
      if (onFinish != null) onFinish();
    }
  }

  //handle pagination request
  Future<Success<T>?> handlePaginationRequest<T>(
    Future<Result<T>> Function() request, {
    bool showLoading = true,
    bool showErrorSnackbar = true,
    VoidCallback? onInit,
    Function(Success<T> data)? onSuccess,
    VoidCallback? onError,
    VoidCallback? onFinish,
  }) async {
    if (onInit != null) onInit();
    if (showLoading) isLoading.value = true;
    error.value = null;

    try {
      final result = await request();

      switch (result) {
        case Success<T> success:
          if (onSuccess != null) onSuccess(success);
          return success;

        case Error<T> error:
          this.error.value = error;
          if (onError != null) onError();

          // Show error snackbar only if not already shown by BaseApiService
          if (showErrorSnackbar) {
            ErrorHandlerService.to.handleError(
              GeneralException(error.message ?? "Error Occured"),
            );
          }
          return null;

        case Cancelled<T> _:
          // Request was cancelled, don't show error
          return null;

        case Loading<T> _:
          // This shouldn't happen in this pattern
          return null;
      }
    } catch (e) {
      final message = 'Unexpected error: $e';
      error.value = Error(message);

      if (showErrorSnackbar) {
        ErrorHandlerService.to.handleError(GeneralException(message));
      }

      if (onError != null) onError();
      return null;
    } finally {
      if (showLoading) isLoading.value = false;
      if (onFinish != null) onFinish();
    }
  }

  // Handle multiple requests in parallel
  Future<List<T>> handleMultipleRequests<T>(
    List<Future<Result<T>> Function()> requests, {
    bool showLoading = true,
    bool showErrorSnackbar = true,
    VoidCallback? onSuccess,
    VoidCallback? onError,
  }) async {
    if (showLoading) isLoading.value = true;
    error.value = null;

    try {
      final futures = requests.map((request) => request()).toList();
      final results = await Future.wait(futures);
      final data = <T>[];

      for (final result in results) {
        if (result is Success<T>) {
          data.add(result.data);
        } else if (result is Error<T>) {
          error.value = result;
          if (onError != null) onError();

          if (showErrorSnackbar) {
            ErrorHandlerService.to.handleError(
              GeneralException(result.message ?? "Error Occured"),
            );
          }
          return [];
        }
      }

      if (onSuccess != null) onSuccess();
      return data;
    } catch (e) {
      final message = 'Error executing multiple requests: $e';
      error.value = Error(message);

      if (showErrorSnackbar) {
        ErrorHandlerService.to.handleError(GeneralException(message));
      }

      if (onError != null) onError();
      return [];
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }

  Future<List<T>> handleMultipleRequestsCallback<T>(
    List<Future<Result<T>> Function()> requests, {
    bool showLoading = true,
    bool showErrorSnackbar = true,
    VoidCallback? onInit,
    Function(List<T> data)? onSuccess,
    VoidCallback? onError,
    VoidCallback? onFinish,
  }) async {
    if (onInit != null) onInit();
    if (showLoading) isLoading.value = true;
    error.value = null;

    try {
      final futures = requests.map((request) => request()).toList();
      final results = await Future.wait(futures);

      final data = <T>[];

      for (final result in results) {
        if (result is Success<T>) {
          data.add(result.data);
        } else if (result is Error<T>) {
          error.value = result;
          if (onError != null) onError();

          if (showErrorSnackbar) {
            ErrorHandlerService.to.handleError(
              GeneralException(result.message ?? "Error Occurred"),
            );
          }
          return [];
        }
      }

      if (onSuccess != null) onSuccess(data);
      return data;
    } catch (e) {
      final message = 'Error executing multiple requests: $e';
      error.value = Error(message);

      if (showErrorSnackbar) {
        ErrorHandlerService.to.handleError(GeneralException(message));
      }

      if (onError != null) onError();
      return [];
    } finally {
      if (showLoading) isLoading.value = false;
      if (onFinish != null) onFinish();
    }
  }
}
