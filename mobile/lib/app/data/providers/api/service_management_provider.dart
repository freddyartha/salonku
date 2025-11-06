import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class ServiceManagementProvider extends ApiProvider {
  // final String _lang = TranslationService.locale.languageCode;

  //Salon Cabang
  Future<Response> getServiceManagementByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
    int? idCabang,
  }) async {
    return await get(
      ApiConstants.getServiceManagementByIdSalon(
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

  Future<Response> createServiceManagement(Map<String, dynamic> model) async {
    return await post(
      ApiConstants.postServiceManagement,
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> updateServiceManagement(
    int id,
    Map<String, dynamic> model,
  ) async {
    return await put(
      ApiConstants.putServiceManagementById(id),
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> getServiceManagementById(int id) async {
    return await get(
      ApiConstants.getServiceManagementById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> deleteServiceManagementById(int id) async {
    return await delete(
      ApiConstants.deleteServiceManagementById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
