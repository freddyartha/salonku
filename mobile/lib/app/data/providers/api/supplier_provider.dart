import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class SupplierProvider extends ApiProvider {
  // final String _lang = TranslationService.locale.languageCode;

  //Salon Cabang
  Future<Response> getSupplierByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) async {
    return await get(
      ApiConstants.getSupplierByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> createSupplier(Map<String, dynamic> model) async {
    return await post(
      ApiConstants.postSupplier,
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> updateSupplier(int id, Map<String, dynamic> model) async {
    return await put(
      ApiConstants.putSupplierById(id),
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> getSupplierById(int id) async {
    return await get(
      ApiConstants.getSupplierById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> deleteSupplierById(int id) async {
    return await delete(
      ApiConstants.deleteSupplierById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
