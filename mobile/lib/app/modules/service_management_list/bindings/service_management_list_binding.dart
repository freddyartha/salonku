import 'package:get/get.dart';

import '../controllers/service_management_list_controller.dart';

class ServiceManagementListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceManagementListController>(
      () => ServiceManagementListController(),
    );
  }
}
