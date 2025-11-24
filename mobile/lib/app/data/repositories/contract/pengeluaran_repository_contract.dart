import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/service_model.dart';

abstract class PengeluaranRepositoryContract {
  Future<Result<List<ServiceModel>>> getPengeluaranList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
    int? idCabang,
  });

  Future<Result<ServiceModel>> getPengeluaranById(int id);

  Future<Result<List>> deletePengeluaranById(int id);

  Future<Result<ServiceModel>> createPengeluaran(Map<String, dynamic> model);

  Future<Result<ServiceModel>> updatePengeluaran(
    int id,
    Map<String, dynamic> model,
  );
}
