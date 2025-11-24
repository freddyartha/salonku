import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/network/general_api_response_parser.dart';
import 'package:salonku/app/data/network/paged_api_response_parser.dart';
import 'package:salonku/app/data/network/simple_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/pengeluaran_provider.dart';
import 'package:salonku/app/data/repositories/contract/pengeluaran_repository_contract.dart';
import 'package:salonku/app/models/service_model.dart';

class PengeluaranRepositoryImpl extends BaseRepository
    implements PengeluaranRepositoryContract {
  final PengeluaranProvider _provider = Get.find();

  @override
  Future<Result<List<ServiceModel>>> getPengeluaranList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
    int? idCabang,
  }) {
    return executeRequest(
      () => _provider.getPengeluaranList(
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
  Future<Result<ServiceModel>> getPengeluaranById(int id) {
    return executeRequest(
      () => _provider.getPengeluaranById(id),
      GeneralApiResponseParser(ServiceModel.fromDynamic),
    );
  }

  @override
  Future<Result<List>> deletePengeluaranById(int id) {
    return executeRequest(
      () => _provider.deletePengeluaranById(id),
      SimpleApiResponseParser((res) => []),
    );
  }

  @override
  Future<Result<ServiceModel>> createPengeluaran(Map<String, dynamic> model) {
    return executeRequest(
      () => _provider.createPengeluaran(model),
      GeneralApiResponseParser(ServiceModel.fromDynamic),
    );
  }

  @override
  Future<Result<ServiceModel>> updatePengeluaran(
    int id,
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.updatePengeluaran(id, model),
      GeneralApiResponseParser(ServiceModel.fromDynamic),
    );
  }
}
