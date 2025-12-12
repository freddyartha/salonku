import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/income_expense_list_model.dart';
import 'package:salonku/app/models/income_expense_model.dart';
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
    int? idCabang,
    String? keyword,
  });

  Future<Result<SalonCabangModel>> getCabangById(int id);

  Future<Result<SalonCabangModel>> createCabang(Map<String, dynamic> model);

  Future<Result<SalonCabangModel>> updateCabangById(
    int id,
    Map<String, dynamic> model,
  );

  Future<Result<List>> deleteCabangById(int id);

  Future<Result<IncomeExpenseModel>> getIncomeExpenseSummary(
    int idSalon,
    int? idCabang,
    DateTime fromDate,
    DateTime toDate,
  );

  Future<Result<List<IncomeExpenseListModel>>> getIncomeExpenseList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    required DateTime fromDate,
    required DateTime toDate,
    int? idCabang,
    String? keyword,
  });

  Future<Result<String>> getTransactionReport({
    required int idSalon,
    required DateTime fromDate,
    required DateTime toDate,
    int? idCabang,
  });
}
