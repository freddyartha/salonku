import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/providers/api/salon_provider.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/models/salon_model.dart';
import 'package:salonku/app/data/network/general_api_response_parser.dart';
import 'package:salonku/app/models/salon_summary_model.dart';

class SalonRepositoryImpl extends BaseRepository
    implements SalonRepositoryContract {
  final SalonProvider _provider = Get.find();

  @override
  Future<Result<SalonModel>> createSalon(Map<String, dynamic> salonModel) {
    return executeRequest(
      () => _provider.createSalon(salonModel),
      GeneralApiResponseParser(SalonModel.fromDynamic),
    );
  }

  @override
  Future<Result<SalonModel>> getSalonByKodeSalon(String kodeSalon) {
    return executeRequest(
      () => _provider.getSalonByKodeSalon(kodeSalon),
      GeneralApiResponseParser(SalonModel.fromDynamic),
    );
  }

  @override
  Future<Result<SalonModel>> getSalonById(int idSalon) {
    return executeRequest(
      () => _provider.getSalonById(idSalon),
      GeneralApiResponseParser(SalonModel.fromDynamic),
    );
  }

  @override
  Future<Result<SalonSummaryModel>> getSalonSummary(int idSalon) {
    return executeRequest(
      () => _provider.getSalonSummary(idSalon),
      GeneralApiResponseParser(SalonSummaryModel.fromDynamic),
    );
  }
}
