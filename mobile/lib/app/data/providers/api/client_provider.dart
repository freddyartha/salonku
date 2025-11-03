import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class ClientProvider extends ApiProvider {
  // final String _lang = TranslationService.locale.languageCode;

  //Salon Cabang
  Future<Response> getClientByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) async {
    return await get(
      ApiConstants.getClientByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> createClient(Map<String, dynamic> model) async {
    return await post(
      ApiConstants.postClient,
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> updateClient(int id, Map<String, dynamic> model) async {
    return await put(
      ApiConstants.putClientById(id),
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> getClientById(int id) async {
    return await get(
      ApiConstants.getClientById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> deleteClientById(int id) async {
    return await delete(
      ApiConstants.deleteClientById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
