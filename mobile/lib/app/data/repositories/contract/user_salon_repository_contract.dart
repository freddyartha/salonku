import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/models/user_model.dart';

abstract class UserSalonRepositoryContract {
  Future<Result<UserModel>> getUserSalonByFirebaseId({
    required String userFirebaseId,
  });
}
