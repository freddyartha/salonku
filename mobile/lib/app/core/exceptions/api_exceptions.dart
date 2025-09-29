abstract class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? errors;

  const ApiException(this.message, {this.statusCode, this.errors});

  @override
  String toString() => 'ApiException: $message';
}

class BadRequestException extends ApiException {
  const BadRequestException(super.message, {super.errors})
    : super(statusCode: 400);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException(super.message, {super.errors})
    : super(statusCode: 401);
}

class ForbiddenException extends ApiException {
  const ForbiddenException(super.message, {super.errors})
    : super(statusCode: 403);
}

class NotFoundException extends ApiException {
  const NotFoundException(super.message, {super.errors})
    : super(statusCode: 404);
}

class ConflictException extends ApiException {
  const ConflictException(super.message, {super.errors})
    : super(statusCode: 409);
}

class ValidationException extends ApiException {
  const ValidationException(super.message, {super.errors})
    : super(statusCode: 422);
}

class ServerException extends ApiException {
  const ServerException(super.message, {int? statusCode, super.errors})
    : super(statusCode: statusCode ?? 500);
}

class RequestCancelledException extends ApiException {
  const RequestCancelledException(super.message) : super(statusCode: null);
}
