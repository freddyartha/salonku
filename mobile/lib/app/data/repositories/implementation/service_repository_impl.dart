import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/network/general_api_response_parser.dart';
import 'package:salonku/app/data/network/paged_api_response_parser.dart';
import 'package:salonku/app/data/network/simple_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/service_provider.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';
import 'package:salonku/app/models/service_model.dart';

class ServiceRepositoryImpl extends BaseRepository
    implements ServiceRepositoryContract {
  final ServiceProvider _provider = Get.find();

  @override
  Future<Result<List<ServiceModel>>> getServiceList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
    int? idCabang,
  }) {
    return executeRequest(
      () => _provider.getServiceList(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
        idCabang: idCabang,
      ),
      PagedApiResponseParser(ServiceModel.fromDynamic),
    );
  }

  @override
  Future<Result<ServiceModel>> getServiceById(int id) {
    return executeRequest(
      () => _provider.getServiceById(id),
      GeneralApiResponseParser(ServiceModel.fromDynamic),
    );
  }

  @override
  Future<Result<List>> deleteServiceById(int id) {
    return executeRequest(
      () => _provider.deleteServiceById(id),
      SimpleApiResponseParser((res) => []),
    );
  }

  @override
  Future<Result<ServiceModel>> createService(Map<String, dynamic> model) {
    return executeRequest(
      () => _provider.createService(model),
      GeneralApiResponseParser(ServiceModel.fromDynamic),
    );
  }

  @override
  Future<Result<ServiceModel>> updateService(
    int id,
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.updateService(id, model),
      GeneralApiResponseParser(ServiceModel.fromDynamic),
    );
  }
}
