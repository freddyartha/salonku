import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/app/core/exceptions/api_exceptions.dart';
import 'package:mobile/app/core/exceptions/network_exceptions.dart';
import 'package:mobile/app/data/providers/local/local_data_source.dart';
import 'package:mobile/app/routes/app_pages.dart';

class ErrorHandlerService extends GetxService {
  static ErrorHandlerService get to => Get.find();

  // Track if snackbar is currently showing to prevent spam
  bool _isShowingSnackbar = false;
  Timer? _snackbarTimer;

  void handleError(Exception error, {bool showSnackbar = true}) {
    final message = _getErrorMessage(error);

    // Log error for debugging
    _logError(error, message);

    // Show user-friendly message
    if (showSnackbar && message.isNotEmpty) {
      _showErrorSnackbar(message);
    }

    // Handle specific error types
    _handleSpecificErrors(error);
  }

  String _getErrorMessage(Exception error) {
    switch (error.runtimeType) {
      case const (BadRequestException):
        return (error as BadRequestException).message;
      case const (UnauthorizedException):
        return (error as UnauthorizedException).errors?["message"].toString() ??
            error.message;
      case const (ForbiddenException):
        return 'Anda tidak memiliki akses untuk melakukan aksi ini';
      case const (NotFoundException):
        return 'Data yang dicari tidak ditemukan';
      case const (ConflictException):
        return 'Data sudah ada atau terjadi konflik';
      case const (ValidationException):
        return _formatValidationError(error as ValidationException);
      case const (ServerException):
        return 'Server sedang bermasalah, coba lagi nanti';
      case const (ConnectionTimeoutException):
        return 'Koneksi timeout, periksa jaringan Anda';
      case const (SendTimeoutException):
        return 'Timeout saat mengirim data';
      case const (ReceiveTimeoutException):
        return 'Timeout saat menerima data';
      case const (NoInternetException):
        return 'Tidak ada koneksi internet';
      case const (ConnectionErrorException):
        return 'Gagal terhubung ke server';
      case const (RequestCancelledException):
        return ''; // Don't show message for cancelled requests
      case const (GeneralException):
        return (error as GeneralException).message;
      default:
        return 'Terjadi kesalahan yang tidak diketahui';
    }
  }

  String _formatValidationError(ValidationException error) {
    final errors = error.errors;
    if (errors != null && errors.isNotEmpty) {
      // Try to format validation errors nicely
      final List<String> errorMessages = [];

      errors.forEach((field, messages) {
        for (final message in messages) {
          errorMessages.add('$field: $message');
        }
      });

      if (errorMessages.isNotEmpty) {
        return errorMessages.join('\n');
      }
    }

    return error.message;
  }

  void _showErrorSnackbar(String message) {
    if (_isShowingSnackbar) return;

    _isShowingSnackbar = true;

    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: Duration(seconds: 4),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      icon: Icon(Icons.error_outline, color: Get.theme.colorScheme.onError),
      shouldIconPulse: false,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
    );

    // Reset flag after snackbar duration + animation time
    _snackbarTimer?.cancel();
    _snackbarTimer = Timer(Duration(seconds: 5), () {
      _isShowingSnackbar = false;
    });
  }

  void showSuccess(String message) {
    if (_isShowingSnackbar) return;

    _isShowingSnackbar = true;

    Get.snackbar(
      'Berhasil',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Get.theme.colorScheme.onPrimary,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      icon: Icon(
        Icons.check_circle_outline,
        color: Get.theme.colorScheme.onPrimary,
      ),
      shouldIconPulse: false,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
    );

    _snackbarTimer?.cancel();
    _snackbarTimer = Timer(Duration(seconds: 4), () {
      _isShowingSnackbar = false;
    });
  }

  void showWarning(String message) {
    if (_isShowingSnackbar) return;

    _isShowingSnackbar = true;

    Get.snackbar(
      'Peringatan',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      icon: Icon(Icons.warning_outlined, color: Colors.white),
      shouldIconPulse: false,
      isDismissible: true,
    );

    _snackbarTimer?.cancel();
    _snackbarTimer = Timer(Duration(seconds: 4), () {
      _isShowingSnackbar = false;
    });
  }

  void showInfo(String message) {
    if (_isShowingSnackbar) return;

    _isShowingSnackbar = true;

    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      icon: Icon(Icons.info_outline, color: Colors.white),
      shouldIconPulse: false,
      isDismissible: true,
    );

    _snackbarTimer?.cancel();
    _snackbarTimer = Timer(Duration(seconds: 4), () {
      _isShowingSnackbar = false;
    });
  }

  void _logError(Exception error, String message) {
    developer.log(
      'Error: $message',
      name: 'ERROR_HANDLER',
      error: error,
      stackTrace: StackTrace.current,
    );
  }

  void _handleSpecificErrors(Exception error) {
    switch (error.runtimeType) {
      case UnauthorizedException _:
        _handleUnauthorizedError();
        break;
      case NoInternetException _:
        _handleNoInternetError();
        break;
      case ServerException _:
        _handleServerError(error as ServerException);
        break;
    }
  }

  void _handleUnauthorizedError() {
    // Clear user session and redirect to login
    if (Get.currentRoute != Routes.LOGIN) {
      Get.find<LocalDataSource>().clearAllCache();
      Get.offAllNamed(Routes.LOGIN);

      // Show session expired dialog
      Future.delayed(Duration(milliseconds: 500), () {
        if (Get.currentRoute == Routes.LOGIN) {
          Get.dialog(
            AlertDialog(
              title: Text('Sesi Berakhir'),
              content: Text('Silakan login kembali untuk melanjutkan'),
              actions: [
                TextButton(onPressed: () => Get.back(), child: Text('OK')),
              ],
            ),
          );
        }
      });
    }
  }

  void _handleNoInternetError() {
    // Show no internet dialog with retry option
    if (!Get.isDialogOpen!) {
      Get.dialog(
        AlertDialog(
          title: Row(
            children: [
              Icon(Icons.wifi_off, color: Colors.red),
              SizedBox(width: 8),
              Text('Tidak Ada Internet'),
            ],
          ),
          content: Text('Periksa koneksi internet Anda dan coba lagi'),
          actions: [TextButton(onPressed: () => Get.back(), child: Text('OK'))],
        ),
        barrierDismissible: false,
      );
    }
  }

  void _handleServerError(ServerException error) {
    // Handle different server error status codes
    if (error.statusCode == 503) {
      // Service unavailable - show maintenance message
      if (!Get.isDialogOpen!) {
        Get.dialog(
          AlertDialog(
            title: Text('Server Maintenance'),
            content: Text('Server sedang dalam pemeliharaan. Coba lagi nanti.'),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text('OK')),
            ],
          ),
        );
      }
    }
  }

  @override
  void onClose() {
    _snackbarTimer?.cancel();
    super.onClose();
  }
}

class GeneralException implements Exception {
  final String message;
  GeneralException(this.message);
}
