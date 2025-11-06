import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/staff_provider.dart';
import 'package:salonku/app/data/repositories/contract/staff_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/staff_repository_impl.dart';

import '../controllers/staff_setup_controller.dart';

class StaffSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffProvider>(() => StaffProvider());
    Get.lazyPut<StaffRepositoryContract>(() => StaffRepositoryImpl());
    Get.lazyPut<StaffSetupController>(
      () => StaffSetupController(Get.find<StaffRepositoryContract>()),
    );
  }
}
