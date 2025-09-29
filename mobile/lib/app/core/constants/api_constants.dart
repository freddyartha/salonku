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
  static String checkUserRegistered = "$api/check-user-registered";
  static String login = "$api/login";
  static String currentUser = "$api/current-user";
  static String logout = "$api/logout";
  static String requestOtp = "$api/otp/smsuser";
  static String verifyOtp(String token) => "$api/otp/smsuser/$token";
  static String register = "$api/register";
  static String refreshToken = "$api/refresh-token";
  static String forgotPassword = "$api/forgot-password";
  static String user = "$api/user";

  static String? avatarUrl(String? path) =>
      path == null || path.isEmpty
          ? null
          : "${EnvironmentConfig.hostUrl}/$path";

  static String termConditions = "${EnvironmentConfig.hostUrl}/privacy-policy";
}
