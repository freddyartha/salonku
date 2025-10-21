import 'package:get/get.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/providers/local/local_data_source_impl.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/user_salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/salon_repository_impl.dart';
import 'package:salonku/app/data/repositories/implementation/user_salon_repository_impl.dart';

import '../controllers/register_salon_controller.dart';

class RegisterSalonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalonRepositoryContract>(() => SalonRepositoryImpl());
    Get.lazyPut<UserSalonRepositoryContract>(() => UserSalonRepositoryImpl());
    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl());
    Get.lazyPut<RegisterSalonController>(
      () => RegisterSalonController(
        Get.find<SalonRepositoryContract>(),
        Get.find<UserSalonRepositoryContract>(),
        Get.find<LocalDataSource>(),
      ),
    );
  }
}
