import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class BookingProvider extends ApiProvider {
  // final String _lang = TranslationService.locale.languageCode;

  Future<Response> getBookingByUserId({
    required int idUser,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) async {
    return await get(
      ApiConstants.getBookingByUserId(
        idUser: idUser,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  // //Salon Cabang
  // Future<Response> getStaffByIdSalon({
  //   required int idSalon,
  //   required int pageIndex,
  //   required int pageSize,
  //   String? keyword,
  // }) async {
  //   return await get(
  //     ApiConstants.getStaffByIdSalon(
  //       idSalon: idSalon,
  //       pageIndex: pageIndex,
  //       pageSize: pageSize,
  //       keyword: keyword,
  //     ),
  //     requiresAuth: true,
  //     includeFirebaseToken: true,
  //   );
  // }

  // Future<Response> updateStaff(int id, Map<String, dynamic> model) async {
  //   return await put(
  //     ApiConstants.putStaffById(id),
  //     data: model,
  //     requiresAuth: true,
  //     includeFirebaseToken: true,
  //   );
  // }

  // Future<Response> getStaffById(int id) async {
  //   return await get(
  //     ApiConstants.getStaffById(id),
  //     requiresAuth: true,
  //     includeFirebaseToken: true,
  //   );
  // }

  // Future<Response> deactivateStaff(int idStaff) async {
  //   return await patch(
  //     ApiConstants.deactivateStaff(idStaff),
  //     requiresAuth: true,
  //     includeFirebaseToken: true,
  //   );
  // }

  // Future<Response> promoteDemoteStaff(int idStaff, bool promote) async {
  //   return await patch(
  //     ApiConstants.promoteDemoteStaff(idStaff, promote),
  //     requiresAuth: true,
  //     includeFirebaseToken: true,
  //   );
  // }
}
