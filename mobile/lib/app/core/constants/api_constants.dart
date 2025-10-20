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
}
