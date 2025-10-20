import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class SalonProvider extends ApiProvider {
  // final String _lang = TranslationService.locale.languageCode;

  Future<Response> createSalon(Map<String, dynamic> salonModel) async {
    return await post(
      ApiConstants.createSalon,
      data: salonModel,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
