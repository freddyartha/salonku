import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/user_model.dart';

abstract class StaffRepositoryContract {
  Future<Result<List<UserModel>>> getStaffByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  });

  Future<Result<UserModel>> getStaffById(int id);

  Future<Result<UserModel>> updateStaffById(int id, Map<String, dynamic> model);
}
