import 'package:get/get.dart';

import '../controllers/salon_cabang_list_controller.dart';

class SalonCabangListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalonCabangListController>(() => SalonCabangListController());
  }
}
