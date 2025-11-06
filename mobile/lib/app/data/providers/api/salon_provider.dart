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

  Future<Response> updateSalon(
    int idSalon,
    Map<String, dynamic> salonModel,
  ) async {
    return await put(
      ApiConstants.updateSalon(idSalon),
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

  //Salon Cabang
  Future<Response> getCabangByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    int? idCabang,
    String? keyword,
  }) async {
    return await get(
      ApiConstants.getCabangByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        idCabang: idCabang,
        keyword: keyword,
      ),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> createCabang(Map<String, dynamic> model) async {
    return await post(
      ApiConstants.postCabang,
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> updateCabang(int id, Map<String, dynamic> model) async {
    return await put(
      ApiConstants.putCabangById(id),
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> getCabangById(int id) async {
    return await get(
      ApiConstants.getCabangById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> deleteCabangById(int id) async {
    return await delete(
      ApiConstants.deleteCabangById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
