import 'package:dio/dio.dart';

abstract class HttpExceptionMapper {
  /// Fungsi untuk mem-parsing [DioException] dari Dio.
  /// Implementasi harus mengubah default DioException menjadi [Exception],
  /// yang berisi [message] dan [errors] jika ada.
  Exception map(DioException error);
}
