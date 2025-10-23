import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/service_model.dart';

abstract class ServiceRepositoryContract {
  Future<Result<List<ServiceModel>>> getServiceList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  });
}
