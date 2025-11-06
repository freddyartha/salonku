import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/service_management_model.dart';

abstract class ServiceManagementRepositoryContract {
  Future<Result<List<ServiceManagementModel>>> getServiceManagementByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
    int? idCabang,
  });

  Future<Result<ServiceManagementModel>> getServiceManagementById(int id);

  Future<Result<ServiceManagementModel>> createServiceManagement(
    Map<String, dynamic> model,
  );

  Future<Result<ServiceManagementModel>> updateServiceManagementById(
    int id,
    Map<String, dynamic> model,
  );

  Future<Result<List>> deleteServiceManagementById(int id);
}
