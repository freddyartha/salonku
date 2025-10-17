import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:salonku/app/core/exceptions/api_exceptions.dart';
import 'package:salonku/app/core/exceptions/network_exceptions.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/providers/network/mapper/http_exception_mapper.dart';
import 'package:salonku/app/data/providers/network/parser/api_response_parser.dart';

class BaseApiService extends GetxService {
  Future<Result<T>> executeRequest<T>(
    Future<Response> Function() request,
    ApiResponseParser<T> parser, {
    required HttpExceptionMapper exceptionMapper,
  }) async {
    try {
      final response = await request();

      // Delegasikan proses parsing ke objek parser yang diberikan.
      // BaseApiService tidak perlu tahu lagi struktur JSON respons.
      final result = parser.parse(response);

      return result;
    } on DioException catch (e) {
      e.printInfo();
      // Handle cancelled requests
      if (e.type == DioExceptionType.cancel) {
        return const Cancelled();
      }

      final exception = _mapDioErrorToException(
        e,
        exceptionMapper: exceptionMapper,
      );

      return Error(
        _getErrorMessage(exception),
        statusCode: e.response?.statusCode,
        errors: _getErrorDetail(exception),
      );
    } catch (e) {
      // Handle unexpected errors
      final message = 'Unexpected error: $e';
      developer.log('BaseApiService unexpected error: $e', name: 'API_SERVICE');

      return Error(message);
    }
  }

  // Execute multiple requests in parallel
  Future<Result<List<T>>> executeMultipleRequests<T>(
    List<Future<Response> Function()> requests,
    ApiResponseParser<T> parser, {
    required HttpExceptionMapper exceptionMapper,
    bool failFast = false, // If true, stop on first error
  }) async {
    try {
      final List<T> results = [];
      if (failFast) {
        // Execute sequentially, stop on first error
        for (final request in requests) {
          final result = await executeRequest(
            request,
            parser,
            exceptionMapper: exceptionMapper,
          );

          if (result is Success<T>) {
            results.add(result.data);
          } else if (result is Error<T>) {
            return Error(
              result.message,
              statusCode: result.statusCode,
              errors: result.errors,
            );
          }
        }
      } else {
        final futures = requests
            .map(
              (req) =>
                  executeRequest(req, parser, exceptionMapper: exceptionMapper),
            )
            .toList();

        final responses = await Future.wait(futures);

        for (final response in responses) {
          if (response is Success<T>) {
            results.add(response.data);
          } else if (response is Error<T>) {
            return Error(
              response.message,
              statusCode: response.statusCode,
              errors: response.errors,
            );
          }
        }
      }
      return Success(results);
    } catch (e) {
      final message = 'Error executing multiple requests: $e';
      return Error(message);
    }
  }

  // Execute request with retry logic
  Future<Result<T>> executeRequestWithRetry<T>(
    Future<Response> Function() request,
    ApiResponseParser<T> parser, {
    required HttpExceptionMapper exceptionMapper,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
  }) async {
    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      final result = await executeRequest(
        request,
        parser,
        exceptionMapper: exceptionMapper,
      );

      if (result is Success<T> || result is Cancelled<T>) {
        return result;
      }

      // If this is the last attempt, handle the error
      if (attempt == maxRetries) {
        return result;
      }

      // Wait before retry
      await Future.delayed(retryDelay);
    }

    return Error('Max retries exceeded');
  }

  Exception _mapDioErrorToException(
    DioException error, {
    required HttpExceptionMapper exceptionMapper,
  }) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeoutException();
      case DioExceptionType.sendTimeout:
        return SendTimeoutException();
      case DioExceptionType.receiveTimeout:
        return ReceiveTimeoutException();
      case DioExceptionType.badCertificate:
        return BadCertificateException();
      case DioExceptionType.badResponse:
        return exceptionMapper.map(error);
      case DioExceptionType.cancel:
        return RequestCancelledException('Request was cancelled');
      case DioExceptionType.connectionError:
        return ConnectionErrorException();
      case DioExceptionType.unknown:
        return UnknownNetworkException();
    }
  }

  String _getErrorMessage(Exception exception) {
    if (exception is ApiException) {
      return exception.message;
    } else if (exception is NetworkException) {
      return exception.message;
    } else {
      return exception.toString();
    }
  }

  Map<String, dynamic>? _getErrorDetail(Exception exception) {
    if (exception is ApiException) {
      return exception.errors;
    } else {
      return null;
    }
  }
}
