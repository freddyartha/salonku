import 'package:get/get.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/salon_repository_impl.dart';

import '../controllers/register_salon_controller.dart';

class RegisterSalonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalonRepositoryContract>(() => SalonRepositoryImpl());
    Get.lazyPut<RegisterSalonController>(
      () => RegisterSalonController(Get.find<SalonRepositoryContract>()),
    );
  }
}
