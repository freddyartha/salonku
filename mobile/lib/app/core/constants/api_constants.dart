import '../../config/environment.dart';

class ApiConstants {
  static const String contentTypeJson = 'application/json';
  static const String contentTypeForm = 'multipart/form-data';
  static const String accept = 'application/json';

  // Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAccept = 'Accept';
  static const String headerAuthorization = 'Authorization';
  // -- Endpoint --
  static final api = "${EnvironmentConfig.hostUrl}/api";

  //user
  static String getUserSalonByFirebaseId(String userFirebaseId) =>
      "$api/user-salon/$userFirebaseId";
  static String registerUser = "$api/user-register";

  //salon
  static String createSalon = "$api/salon";
  static String updateSalon(int idSalon) => "$api/salon/$idSalon";
  static String userAddSalon(int userId) => '$api/user-salon/$userId/add-salon';
  static String getSalonByIdSalon(int idSalon) => '$api/salon/$idSalon';
  static String getSalonByKodeSalon(String kodeSalon) =>
      '$api/salon/kode/$kodeSalon';
  static String userRemoveSalon(int userId) =>
      '$api/user-salon/$userId/remove-salon';
  static String getSalonSummary(int salonId) =>
      '$api/general/salon-summary/$salonId';

  //service
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

  //cabang
  static String getCabangByIdSalon({
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
    return "$api/salon/$idSalon/cabang/list?$queryString";
  }

  static String postCabang = '$api/salon/cabang';
  static String putCabangById(int id) => '$api/salon/cabang/$id';
  static String getCabangById(int id) => '$api/salon/cabang/$id';
  static String deleteCabangById(int id) => '$api/salon/cabang/$id/delete';
}
