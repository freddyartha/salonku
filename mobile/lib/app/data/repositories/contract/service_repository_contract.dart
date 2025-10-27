import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/service_model.dart';

abstract class ServiceRepositoryContract {
  Future<Result<List<ServiceModel>>> getServiceList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  });

  Future<Result<ServiceModel>> getServiceById(int id);

  Future<Result<List>> deleteServiceById(int id);

  Future<Result<ServiceModel>> createService(Map<String, dynamic> model);

  Future<Result<ServiceModel>> updateService(
    int id,
    Map<String, dynamic> model,
  );
}
