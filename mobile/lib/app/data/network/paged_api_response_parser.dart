import 'package:dio/dio.dart';

import '../models/result.dart';
import '../providers/network/parser/api_response_parser.dart';

class PagedApiResponseParser<ListType, T> extends ApiResponseParser<List<T>> {
  final T Function(Map<String, dynamic> json) fromJson;

  PagedApiResponseParser(this.fromJson);

  @override
  Result<List<T>> parse(Response response) {
    if (response.data is Map<String, dynamic>) {
      final responseData = response.data as Map<String, dynamic>;

      // Cek format standar API
      if (responseData.containsKey('status')) {
        final bool isSuccess = responseData['status'] == true;

        if (isSuccess && responseData.containsKey('data')) {
          final List rawDataList = responseData['data'] as List;
          final List<T> data =
              rawDataList.map<T>((item) {
                if (item is Map<String, dynamic>) {
                  return fromJson(item);
                }
                throw FormatException(
                  "Expected a Map for each item in 'data' list",
                );
              }).toList();

          final meta = responseData['meta'];
          if (meta != null) {
            return Success(data, meta: Meta.fromJson(meta));
          }
          return Success(data);
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
        // Respons adalah JSON object tapi tanpa wrapper 'status'
        if (responseData.containsKey('data')) {
          final List rawDataList = responseData['data'] as List;
          final List<T> data =
              rawDataList.map<T>((item) {
                if (item is Map<String, dynamic>) {
                  return fromJson(item);
                }
                throw FormatException(
                  "Expected a Map for each item in 'data' list",
                );
              }).toList();

          final meta = responseData['meta'];
          if (meta != null) {
            return Success(data, meta: Meta.fromJson(meta));
          }
          return Success(data);
        } else {
          final data =
              responseData['data'].map((data) => fromJson(data)).toList();
          return Success(data);
        }
      }
    } else {
      // Respons bukan JSON object (misalnya list, string, dll)
      final data = response.data.map((data) => fromJson(data)).toList();
      return Success(data);
    }
  }
}
