import 'package:dio/dio.dart';

import '../models/result.dart';
import '../providers/network/parser/api_response_parser.dart';

class GeneralApiResponseParser<T> extends ApiResponseParser<T> {
  /// Fungsi konversi dari JSON ke model [T].
  final T Function(Map<String, dynamic> json) fromJson;

  GeneralApiResponseParser(this.fromJson);

  @override
  Result<T> parse(Response response) {
    if (response.data is Map<String, dynamic>) {
      final responseData = response.data as Map<String, dynamic>;

      // Cek format standar API
      if (responseData.containsKey('status')) {
        final bool isSuccess = responseData['status'] == true;

        if (isSuccess && responseData.containsKey('data')) {
          final data = fromJson(responseData['data']);
          return Success(data);
        } else {
          // API mengembalikan error
          final errors = responseData['errors'];
          String errorMessage = 'Unknown API error';

          if (errors is Map<String, dynamic>) {
            return Error(errorMessage, errors: errors);
          } else if (errors is String) {
            errorMessage = errors;
          } else if (responseData.containsKey('message')) {
            errorMessage = responseData['message'];
          }

          return Error(errorMessage);
        }
      } else {
        // Respons adalah JSON object tapi tanpa wrapper 'status'
        if (responseData.containsKey('data')) {
          final data = fromJson(responseData['data']);
          return Success(data);
        } else {
          final data = fromJson(response.data);
          return Success(data);
        }
      }
    } else {
      // Respons bukan JSON object (misalnya list, string, dll)
      final data = fromJson(response.data);
      return Success(data);
    }
  }
}
