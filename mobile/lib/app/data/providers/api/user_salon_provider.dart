import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class UserSalonProvider extends ApiProvider {
  // final String _lang = TranslationService.locale.languageCode;

  Future<Response> getUserSalonByFirebaseId({
    required String userFirebaseId,
  }) async {
    return await get(
      ApiConstants.getUserSalonByFirebaseId(userFirebaseId),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
