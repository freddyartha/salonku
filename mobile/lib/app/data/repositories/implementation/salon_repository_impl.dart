import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/network/paged_api_response_parser.dart';
import 'package:salonku/app/data/network/simple_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/salon_provider.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/models/income_expense_list_model.dart';
import 'package:salonku/app/models/income_expense_model.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';
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

  @override
  Future<Result<List<SalonCabangModel>>> getCabangByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    int? idCabang,
    String? keyword,
  }) {
    return executeRequest(
      () => _provider.getCabangByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        idCabang: idCabang,
        keyword: keyword,
      ),
      PagedApiResponseParser(SalonCabangModel.fromDynamic),
    );
  }

  @override
  Future<Result<SalonModel>> updateSalon(
    int idSalon,
    Map<String, dynamic> salonModel,
  ) {
    return executeRequest(
      () => _provider.updateSalon(idSalon, salonModel),
      GeneralApiResponseParser(SalonModel.fromDynamic),
    );
  }

  @override
  Future<Result<SalonCabangModel>> createCabang(Map<String, dynamic> model) {
    return executeRequest(
      () => _provider.createCabang(model),
      GeneralApiResponseParser(SalonCabangModel.fromDynamic),
    );
  }

  @override
  Future<Result<SalonCabangModel>> getCabangById(int id) {
    return executeRequest(
      () => _provider.getCabangById(id),
      GeneralApiResponseParser(SalonCabangModel.fromDynamic),
    );
  }

  @override
  Future<Result<SalonCabangModel>> updateCabangById(
    int id,
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.updateCabang(id, model),
      GeneralApiResponseParser(SalonCabangModel.fromDynamic),
    );
  }

  @override
  Future<Result<List>> deleteCabangById(int id) {
    return executeRequest(
      () => _provider.deleteCabangById(id),
      SimpleApiResponseParser((res) => []),
    );
  }

  @override
  Future<Result<IncomeExpenseModel>> getIncomeExpenseSummary(
    int idSalon,
    int? idCabang,
    DateTime fromDate,
    DateTime toDate,
  ) {
    return executeRequest(
      () => _provider.getIncomeExpenseSummary(
        idSalon,
        idCabang,
        fromDate,
        toDate,
      ),
      GeneralApiResponseParser(IncomeExpenseModel.fromDynamic),
    );
  }

  @override
  Future<Result<List<IncomeExpenseListModel>>> getIncomeExpenseList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    required DateTime fromDate,
    required DateTime toDate,
    int? idCabang,
    String? keyword,
  }) {
    return executeRequest(
      () => _provider.getIncomeExpenseList(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        fromDate: fromDate,
        toDate: toDate,
      ),
      PagedApiResponseParser(IncomeExpenseListModel.fromDynamic),
    );
  }
}
