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

  Future<Response> getSalonByKodeSalon(String kodeSalon) async {
    return await get(
      ApiConstants.getSalonByKodeSalon(kodeSalon),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> getSalonById(int idSalon) async {
    return await get(
      ApiConstants.getSalonByIdSalon(idSalon),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> getSalonSummary(int idSalon) async {
    return await get(
      ApiConstants.getSalonSummary(idSalon),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
