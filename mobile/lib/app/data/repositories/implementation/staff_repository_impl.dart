import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/network/general_api_response_parser.dart';
import 'package:salonku/app/data/network/paged_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/staff_provider.dart';
import 'package:salonku/app/data/repositories/contract/staff_repository_contract.dart';
import 'package:salonku/app/models/user_model.dart';

import '../../models/result.dart';

class StaffRepositoryImpl extends BaseRepository
    implements StaffRepositoryContract {
  final StaffProvider _provider = Get.find();

  @override
  Future<Result<List<UserModel>>> getStaffByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    return executeRequest(
      () => _provider.getStaffByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      PagedApiResponseParser(UserModel.fromDynamic),
    );
  }

  @override
  Future<Result<UserModel>> getStaffById(int id) {
    return executeRequest(
      () => _provider.getStaffById(id),
      GeneralApiResponseParser(UserModel.fromDynamic),
    );
  }

  @override
  Future<Result<UserModel>> updateStaffById(
    int id,
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.updateStaff(id, model),
      GeneralApiResponseParser(UserModel.fromDynamic),
    );
  }
}
