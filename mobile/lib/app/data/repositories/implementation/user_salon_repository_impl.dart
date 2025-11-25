import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/user_model.dart';
import 'package:salonku/app/data/network/general_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/user_salon_provider.dart';
import 'package:salonku/app/data/repositories/contract/user_salon_repository_contract.dart';

class UserSalonRepositoryImpl extends BaseRepository
    implements UserSalonRepositoryContract {
  final UserSalonProvider _provider = Get.find();

  @override
  Future<Result<UserModel>> getUserSalonByFirebaseId({
    required String userFirebaseId,
  }) {
    return executeRequest(
      () => _provider.getUserSalonByFirebaseId(userFirebaseId: userFirebaseId),
      GeneralApiResponseParser(UserModel.fromDynamic),
    );
  }

  @override
  Future<Result<UserModel>> registerUser(Map<String, dynamic> userModel) {
    return executeRequest(
      () => _provider.registerNewUser(userModel),
      GeneralApiResponseParser(UserModel.fromDynamic),
    );
  }

  @override
  Future<Result<UserModel>> userAddSalon(int userId, int salonId) {
    return executeRequest(
      () => _provider.userAddSalon(userId, salonId),
      GeneralApiResponseParser(UserModel.fromDynamic),
    );
  }

  @override
  Future<Result<UserModel>> userRemoveSalon(int userId) {
    return executeRequest(
      () => _provider.userRemoveSalon(userId),
      GeneralApiResponseParser(UserModel.fromDynamic),
    );
  }

  @override
  Future<Result<UserModel>> staffApproval(
    int staffId,
    List<int> cabangs,
    bool approval,
  ) {
    return executeRequest(
      () => _provider.staffApproval(staffId, cabangs, approval),
      GeneralApiResponseParser(UserModel.fromDynamic),
    );
  }
}
