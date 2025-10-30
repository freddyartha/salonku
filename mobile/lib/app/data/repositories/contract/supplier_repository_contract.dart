import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/supplier_model.dart';

abstract class SupplierRepositoryContract {
  Future<Result<List<SupplierModel>>> getSupplierByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  });

  Future<Result<SupplierModel>> getSupplierById(int id);

  Future<Result<SupplierModel>> createSupplier(Map<String, dynamic> model);

  Future<Result<SupplierModel>> updateSupplierById(
    int id,
    Map<String, dynamic> model,
  );

  Future<Result<List>> deleteSupplierById(int id);
}
