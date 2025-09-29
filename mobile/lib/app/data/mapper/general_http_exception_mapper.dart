import 'package:dio/dio.dart';

import '../../core/exceptions/api_exceptions.dart';
import '../providers/network/mapper/http_exception_mapper.dart';

class GeneralHttpExceptionMapper extends HttpExceptionMapper {
  @override
  Exception map(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    String message = 'HTTP Error $statusCode';
    Map<String, List<String>> errors = {};

    if (data is Map<String, dynamic>) {
      message = data['message'] ?? message;
      if (data.containsKey("errors")) {
        Map<String, dynamic> errorsMap = data['errors'];
        errorsMap.forEach((key, value) {
          if (value is List) {
            errors[key] =
                value.runtimeType == String
                    ? [value.toString()]
                    : List<String>.from(value);
          } else if (value is String) {
            errors[key] = [value];
          }
        });
      }
    } else if (data is String) {
      message = data;
    }

    switch (statusCode) {
      case 400:
        return BadRequestException(message, errors: errors);
      case 401:
        return UnauthorizedException(message, errors: errors);
      case 403:
        return ForbiddenException(message, errors: errors);
      case 404:
        return NotFoundException(message, errors: errors);
      case 409:
        return ConflictException(message, errors: errors);
      case 422:
        return ValidationException(message, errors: errors);
      case 500:
      case 502:
      case 503:
        return ServerException(message, statusCode: statusCode, errors: errors);
      default:
        return ServerException(message, statusCode: statusCode, errors: errors);
    }
  }
}
