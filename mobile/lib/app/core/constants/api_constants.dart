import '../../config/environment.dart';

class ApiConstants {
  static const String contentTypeJson = 'application/json';
  static const String contentTypeForm = 'multipart/form-data';
  static const String accept = 'application/json';

  // Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAccept = 'Accept';
  static const String headerAuthorization = 'Authorization';
  // Endpoint
  static final api = "${EnvironmentConfig.hostUrl}/api";
  static String getUserSalonByFirebaseId(String userFirebaseId) =>
      "$api/user-salon/$userFirebaseId";
  static String createSalon = "$api/salon";
  static String registerUser = "$api/user-register";
  static String userAddSalon(int userId) => '$api/user-salon/$userId/add-salon';
  static String getSalonByIdSalon(int idSalon) => '$api/salon/$idSalon';
  static String getSalonByKodeSalon(String kodeSalon) =>
      '$api/salon/kode/$kodeSalon';
  static String userRemoveSalon(int userId) =>
      '$api/user-salon/$userId/remove-salon';
  static String getSalonSummary(int salonId) =>
      '$api/general/salon-summary/$salonId';
  static String getServiceList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/service/$idSalon/list?$queryString";
  }

  static String postService = '$api/service';
  static String putServiceById(int id) => '$api/service/$id';
  static String getServiceById(int id) => '$api/service/$id';
  static String deleteServiceById(int id) => '$api/service/$id/delete';
}
