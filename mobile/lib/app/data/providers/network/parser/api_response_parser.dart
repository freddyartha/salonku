import 'package:dio/dio.dart';

import '../../../models/result.dart';

abstract class ApiResponseParser<T> {
  /// Fungsi untuk mem-parsing [Response] dari Dio.
  /// Implementasi harus mengubah respons mentah menjadi [Result<T>],
  /// yang bisa berupa [Success<T>] atau [Error<T>].
  Result<T> parse(Response response);
}
