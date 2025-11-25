import 'package:dio/dio.dart';
import 'package:salonku/app/core/constants/api_constants.dart';
import 'package:salonku/app/data/providers/network/api_provider.dart';

class UserSalonProvider extends ApiProvider {
  // final String _lang = TranslationService.locale.languageCode;

  Future<Response> getUserSalonByFirebaseId({
    required String userFirebaseId,
  }) async {
    return await get(
      ApiConstants.getUserSalonByFirebaseId(userFirebaseId),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> registerNewUser(Map<String, dynamic> userModel) async {
    return await post(
      ApiConstants.registerUser,
      data: userModel,
      requiresAuth: false,
      includeFirebaseToken: true,
    );
  }

  Future<Response> userAddSalon(int userId, int salonId) async {
    return await patch(
      ApiConstants.userAddSalon(userId),
      data: {"id_salon": salonId},
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> userRemoveSalon(int userId) async {
    return await patch(
      ApiConstants.userRemoveSalon(userId),
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }

  Future<Response> staffApproval(
    int staffId,
    List<int> cabangs,
    bool approval,
  ) async {
    return await patch(
      ApiConstants.staffApproval(staffId),
      data: {"cabangs": cabangs, "approval": approval},
      requiresAuth: true,
      includeFirebaseToken: true,
    );
  }
}
