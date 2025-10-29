import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';
import 'package:salonku/app/models/salon_model.dart';
import 'package:salonku/app/models/salon_summary_model.dart';

abstract class SalonRepositoryContract {
  Future<Result<SalonModel>> createSalon(Map<String, dynamic> salonModel);

  Future<Result<SalonModel>> updateSalon(
    int idSalon,
    Map<String, dynamic> salonModel,
  );

  Future<Result<SalonModel>> getSalonByKodeSalon(String kodeSalon);

  Future<Result<SalonModel>> getSalonById(int idSalon);

  Future<Result<SalonSummaryModel>> getSalonSummary(int idSalon);

  //Cabang
  Future<Result<List<SalonCabangModel>>> getCabangByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  });

  Future<Result<SalonCabangModel>> getCabangById(int id);

  Future<Result<SalonCabangModel>> createCabang(Map<String, dynamic> model);

  Future<Result<SalonCabangModel>> updateCabangById(
    int id,
    Map<String, dynamic> model,
  );

  Future<Result<List>> deleteCabangById(int id);
}
