import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:salonku/app/data/mapper/general_http_exception_mapper.dart';
import 'package:salonku/app/services/base_api_service.dart';
import 'package:salonku/app/services/error_handler_service.dart';
import '../../data/models/result.dart';
import '../../data/providers/network/mapper/http_exception_mapper.dart';
import '../../data/providers/network/parser/api_response_parser.dart';

abstract class BaseRepository {
  final BaseApiService _apiService = Get.find();
  HttpExceptionMapper get exceptionMapper => GeneralHttpExceptionMapper();

  // Execute request dengan error handling
  Future<Result<T>> executeRequest<T>(
    Future<Response> Function() request,
    ApiResponseParser<T> parser, {
    String? successMessage,
  }) async {
    final result = await _apiService.executeRequest(
      request,
      parser,
      exceptionMapper: exceptionMapper,
    );
    if (result is Success<T> && successMessage != null) {
      Get.find<ErrorHandlerService>().showSuccess(successMessage);
    }
    return result;
  }

  // Execute multiple requests
  Future<Result<List<T>>> executeMultipleRequests<T>(
    List<Future<Response> Function()> requests,
    ApiResponseParser<T> parser, {
    String? successMessage,
  }) async {
    try {
      final futures = requests
          .map((request) => executeRequest(request, parser))
          .toList();

      final results = await Future.wait(futures);
      final List<T> data = [];

      for (final result in results) {
        if (result is Success<T>) {
          data.add(result.data);
        } else if (result is Error<T>) {
          return Error(result.message, errors: result.errors);
        }
      }

      if (successMessage != null) {
        Get.find<ErrorHandlerService>().showSuccess(successMessage);
      }

      return Success(data);
    } catch (e) {
      final message = 'Terjadi kesalahan: $e';
      return Error(message);
    }
  }
}
