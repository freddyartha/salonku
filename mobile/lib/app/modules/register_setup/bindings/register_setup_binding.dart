import 'package:get/get.dart';

import '../controllers/register_setup_controller.dart';

class RegisterSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterSetupController>(
      () => RegisterSetupController(),
    );
  }
}
