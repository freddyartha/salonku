import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class PaymentMethodProvider extends ApiProvider {
  // final String _lang = TranslationService.locale.languageCode;

  //Salon Cabang
  Future<Response> getPaymentMethodByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) async {
    return await get(
      ApiConstants.getPaymentMethodByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> createPaymentMethod(Map<String, dynamic> model) async {
    return await post(
      ApiConstants.postPaymentMethod,
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> updatePaymentMethod(
    int id,
    Map<String, dynamic> model,
  ) async {
    return await put(
      ApiConstants.putPaymentMethodById(id),
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> getPaymentMethodById(int id) async {
    return await get(
      ApiConstants.getPaymentMethodById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> deletePaymentMethodById(int id) async {
    return await delete(
      ApiConstants.deletePaymentMethodById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
