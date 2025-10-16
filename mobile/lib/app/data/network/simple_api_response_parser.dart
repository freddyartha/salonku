import 'package:dio/dio.dart';

import '../models/result.dart';
import '../providers/network/parser/api_response_parser.dart';

class SimpleApiResponseParser<T> extends ApiResponseParser<T> {
  final T Function(dynamic json) res;
  SimpleApiResponseParser(this.res);

  @override
  Result<T> parse(Response response) {
    if (response.data is Map<String, dynamic>) {
      final responseData = response.data as Map<String, dynamic>;

      // Cek format standar API
      if (responseData.containsKey('status')) {
        final bool isSuccess = responseData['status'] == true;

        if (isSuccess) {
          return Success(res(response.data));
        } else {
          // API mengembalikan error
          final errors = responseData['errors'];
          String errorMessage = 'Unknown API error';

          if (errors is Map<String, dynamic>) {
            // Mengambil pesan error pertama dari daftar error
            final firstErrorList = errors.values.first;
            if (firstErrorList is List && firstErrorList.isNotEmpty) {
              errorMessage = firstErrorList.first.toString();
            }
          } else if (errors is String) {
            errorMessage = errors;
          } else if (responseData.containsKey('message')) {
            errorMessage = responseData['message'];
          }

          return Error(errorMessage);
        }
      } else {
        return Success(res(response.data));
      }
    } else {
      return Success(res(response.data));
    }
  }
}
