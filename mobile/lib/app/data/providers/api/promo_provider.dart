import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class PromoProvider extends ApiProvider {
  // final String _lang = TranslationService.locale.languageCode;

  //Salon Cabang
  Future<Response> getPromoByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) async {
    return await get(
      ApiConstants.getPromoByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> createPromo(Map<String, dynamic> model) async {
    return await post(
      ApiConstants.postPromo,
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> updatePromo(int id, Map<String, dynamic> model) async {
    return await put(
      ApiConstants.putPromoById(id),
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> getPromoById(int id) async {
    return await get(
      ApiConstants.getPromoById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> deletePromoById(int id) async {
    return await delete(
      ApiConstants.deletePromoById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
