import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class PengeluaranProvider extends ApiProvider {
  // final String _lang = TranslationPengeluaran.locale.languageCode;

  Future<Response> getPengeluaranList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
    int? idCabang,
  }) async {
    return await get(
      ApiConstants.getPengeluaranList(
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

  Future<Response> createPengeluaran(Map<String, dynamic> model) async {
    return await post(
      ApiConstants.postPengeluaran,
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> updatePengeluaran(int id, Map<String, dynamic> model) async {
    return await put(
      ApiConstants.putPengeluaranById(id),
      data: model,
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> getPengeluaranById(int id) async {
    return await get(
      ApiConstants.getPengeluaranById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> deletePengeluaranById(int id) async {
    return await delete(
      ApiConstants.deletePengeluaranById(id),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
