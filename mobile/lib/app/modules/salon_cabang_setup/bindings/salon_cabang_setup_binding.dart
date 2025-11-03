import 'package:get/get.dart';

import '../controllers/salon_cabang_setup_controller.dart';

class SalonCabangSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalonCabangSetupController>(() => SalonCabangSetupController());
  }
}
