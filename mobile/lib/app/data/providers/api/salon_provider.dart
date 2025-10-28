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

  Future<Response> getCabangByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) async {
    return await get(
      ApiConstants.getCabangByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
