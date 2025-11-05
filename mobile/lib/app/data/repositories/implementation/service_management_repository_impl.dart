import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/network/paged_api_response_parser.dart';
import 'package:salonku/app/data/network/simple_api_response_parser.dart';
import 'package:salonku/app/data/network/general_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/service_management_provider.dart';
import 'package:salonku/app/data/repositories/contract/service_management_repository_contract.dart';
import 'package:salonku/app/models/service_management_model.dart';

class ServiceManagementRepositoryImpl extends BaseRepository
    implements ServiceManagementRepositoryContract {
  final ServiceManagementProvider _provider = Get.find();

  @override
  Future<Result<List<ServiceManagementModel>>> getServiceManagementByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    return executeRequest(
      () => _provider.getServiceManagementByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      PagedApiResponseParser(ServiceManagementModel.fromDynamic),
    );
  }

  @override
  Future<Result<ServiceManagementModel>> createServiceManagement(
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.createServiceManagement(model),
      GeneralApiResponseParser(ServiceManagementModel.fromDynamic),
    );
  }

  @override
  Future<Result<ServiceManagementModel>> getServiceManagementById(int id) {
    return executeRequest(
      () => _provider.getServiceManagementById(id),
      GeneralApiResponseParser(ServiceManagementModel.fromDynamic),
    );
  }

  @override
  Future<Result<ServiceManagementModel>> updateServiceManagementById(
    int id,
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.updateServiceManagement(id, model),
      GeneralApiResponseParser(ServiceManagementModel.fromDynamic),
    );
  }

  @override
  Future<Result<List>> deleteServiceManagementById(int id) {
    return executeRequest(
      () => _provider.deleteServiceManagementById(id),
      SimpleApiResponseParser((res) => []),
    );
  }
}
