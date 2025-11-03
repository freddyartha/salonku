import 'package:get/get.dart';

import '../controllers/register_salon_controller.dart';

class RegisterSalonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterSalonController>(() => RegisterSalonController());
  }
}
