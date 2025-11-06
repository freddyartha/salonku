import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class ServiceProvider extends ApiProvider {
  // final String _lang = TranslationService.locale.languageCode;

  Future<Response> getServiceList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
    int? idCabang,
  }) async {
    return await get(
      ApiConstants.getServiceList(
        idSalon: idSalon,
        idCabang: idCabang,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> createService(Map<String, dynamic> model) async {
    return await post(
      ApiConstants.postService,
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> updateService(int id, Map<String, dynamic> model) async {
    return await put(
      ApiConstants.putServiceById(id),
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> getServiceById(int id) async {
    return await get(
      ApiConstants.getServiceById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> deleteServiceById(int id) async {
    return await delete(
      ApiConstants.deleteServiceById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
