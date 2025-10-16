import 'package:dio/dio.dart';

import '../models/result.dart';
import '../providers/network/parser/api_response_parser.dart';

class ListApiResponseParser<T> extends ApiResponseParser<List<T>> {
  /// Fungsi konversi dari JSON ke model [T].
  final T Function(Map<String, dynamic> json) fromJson;

  ListApiResponseParser(this.fromJson);

  @override
  Result<List<T>> parse(Response response) {
    if (response.data is Map<String, dynamic>) {
      final responseData = response.data as Map<String, dynamic>;

      // Cek format standar API
      if (responseData.containsKey('status')) {
        final bool isSuccess = responseData['status'] == true;

        if (isSuccess && responseData.containsKey('data')) {
          final rawList = responseData['data'];
          if (rawList is List) {
            final list =
                rawList
                    .map<T>((item) => fromJson(item as Map<String, dynamic>))
                    .toList();
            return Success(list);
          } else {
            return Error("Expected a list of data, but got something else.");
          }
        } else {
          // Menangani error message dari API
          final errors = responseData['errors'];
          String errorMessage = 'Unknown API error';

          if (errors is Map<String, dynamic>) {
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
        // Tanpa wrapper status, langsung cek apakah data list
        if (responseData.containsKey('data')) {
          final rawList = responseData['data'];
          if (rawList is List) {
            final list =
                rawList
                    .map<T>((item) => fromJson(item as Map<String, dynamic>))
                    .toList();
            return Success(list);
          } else {
            return Error("Expected a list of data, but got something else.");
          }
        } else {
          return Error("No 'data' field found in response.");
        }
      }
    } else {
      return Error("Unexpected response format.");
    }
  }
}
