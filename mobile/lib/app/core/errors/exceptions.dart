class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Object? error;

  ApiException({required this.message, this.statusCode, this.error});

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';
}

class ServerException extends ApiException {
  ServerException({
    super.message = 'Terjadi kesalahan pada server',
    super.error,
  }) : super(statusCode: 500);
}

class NotFoundException extends ApiException {
  NotFoundException({super.message = 'Data tidak ditemukan', super.error})
    : super(statusCode: 404);
}

class BadRequestException extends ApiException {
  BadRequestException({super.message = 'Request tidak valid', super.error})
    : super(statusCode: 400);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({
    super.message = 'Tidak memiliki izin akses',
    super.error,
  }) : super(statusCode: 401);
}

class NetworkException extends ApiException {
  NetworkException({
    super.message = 'Gagal terhubung ke jaringan',
    super.error,
  });
}
