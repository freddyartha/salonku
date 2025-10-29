import 'package:get/get.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/salon_repository_impl.dart';

import '../controllers/salon_cabang_setup_controller.dart';

class SalonCabangSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalonRepositoryContract>(() => SalonRepositoryImpl());
    Get.lazyPut<SalonCabangSetupController>(
      () => SalonCabangSetupController(Get.find<SalonRepositoryContract>()),
    );
  }
}
