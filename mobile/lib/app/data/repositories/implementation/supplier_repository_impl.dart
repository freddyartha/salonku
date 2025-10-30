import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/network/paged_api_response_parser.dart';
import 'package:salonku/app/data/network/simple_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/supplier_provider.dart';
import 'package:salonku/app/data/network/general_api_response_parser.dart';
import 'package:salonku/app/data/repositories/contract/supplier_repository_contract.dart';
import 'package:salonku/app/models/supplier_model.dart';

class SupplierRepositoryImpl extends BaseRepository
    implements SupplierRepositoryContract {
  final SupplierProvider _provider = Get.find();

  @override
  Future<Result<List<SupplierModel>>> getSupplierByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    return executeRequest(
      () => _provider.getSupplierByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      PagedApiResponseParser(SupplierModel.fromDynamic),
    );
  }

  @override
  Future<Result<SupplierModel>> createSupplier(Map<String, dynamic> model) {
    return executeRequest(
      () => _provider.createSupplier(model),
      GeneralApiResponseParser(SupplierModel.fromDynamic),
    );
  }

  @override
  Future<Result<SupplierModel>> getSupplierById(int id) {
    return executeRequest(
      () => _provider.getSupplierById(id),
      GeneralApiResponseParser(SupplierModel.fromDynamic),
    );
  }

  @override
  Future<Result<SupplierModel>> updateSupplierById(
    int id,
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.updateSupplier(id, model),
      GeneralApiResponseParser(SupplierModel.fromDynamic),
    );
  }

  @override
  Future<Result<List>> deleteSupplierById(int id) {
    return executeRequest(
      () => _provider.deleteSupplierById(id),
      SimpleApiResponseParser((res) => []),
    );
  }
}
