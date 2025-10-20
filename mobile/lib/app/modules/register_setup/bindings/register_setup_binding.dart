import 'package:get/get.dart';
import 'package:salonku/app/data/repositories/contract/user_salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/user_salon_repository_impl.dart';

import '../controllers/register_setup_controller.dart';

class RegisterSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserSalonRepositoryContract>(() => UserSalonRepositoryImpl());
    Get.lazyPut<RegisterSetupController>(
      () => RegisterSetupController(Get.find<UserSalonRepositoryContract>()),
    );
  }
}
