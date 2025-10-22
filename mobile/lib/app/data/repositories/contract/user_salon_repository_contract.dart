import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/user_model.dart';

abstract class UserSalonRepositoryContract {
  Future<Result<UserModel>> getUserSalonByFirebaseId({
    required String userFirebaseId,
  });
  Future<Result<UserModel>> registerUser(Map<String, dynamic> userModel);

  Future<Result<UserModel>> userAddSalon(int userId, int salonId);

  Future<Result<UserModel>> userRemoveSalon(int userId);
}
