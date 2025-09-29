abstract class NetworkException implements Exception {
  final String message;
  final Exception? originalException;

  const NetworkException(this.message, {this.originalException});

  @override
  String toString() => 'NetworkException: $message';
}

class NoInternetException extends NetworkException {
  const NoInternetException([String? message])
    : super(message ?? 'No internet connection');
}

class ConnectionTimeoutException extends NetworkException {
  const ConnectionTimeoutException([String? message])
    : super(message ?? 'Connection timeout');
}

class SendTimeoutException extends NetworkException {
  const SendTimeoutException([String? message])
    : super(message ?? 'Timeout while sending data');
}

class ReceiveTimeoutException extends NetworkException {
  const ReceiveTimeoutException([String? message])
    : super(message ?? 'Timeout while receiving data');
}

class BadCertificateException extends NetworkException {
  const BadCertificateException([String? message])
    : super(message ?? 'Invalid certificate');
}

class ConnectionErrorException extends NetworkException {
  const ConnectionErrorException([String? message])
    : super(message ?? 'Failed to connect to server');
}

class UnknownNetworkException extends NetworkException {
  const UnknownNetworkException([String? message])
    : super(message ?? 'An unknown network error occurred');
}
