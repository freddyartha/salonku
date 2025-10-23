import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/salon_model.dart';
import 'package:salonku/app/models/salon_summary_model.dart';

abstract class SalonRepositoryContract {
  Future<Result<SalonModel>> createSalon(Map<String, dynamic> salonModel);

  Future<Result<SalonModel>> getSalonByKodeSalon(String kodeSalon);

  Future<Result<SalonModel>> getSalonById(int idSalon);

  Future<Result<SalonSummaryModel>> getSalonSummary(int idSalon);
}
