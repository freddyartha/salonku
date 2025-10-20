import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/salon_model.dart';

abstract class SalonRepositoryContract {
  Future<Result<SalonModel>> createSalon(Map<String, dynamic> salonModel);
}
