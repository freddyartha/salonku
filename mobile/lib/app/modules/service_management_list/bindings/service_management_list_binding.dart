import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/service_management_provider.dart';
import 'package:salonku/app/data/repositories/contract/service_management_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/service_management_repository_impl.dart';

import '../controllers/service_management_list_controller.dart';

class ServiceManagementListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceManagementProvider>(() => ServiceManagementProvider());
    Get.lazyPut<ServiceManagementRepositoryContract>(
      () => ServiceManagementRepositoryImpl(),
    );
    Get.lazyPut<ServiceManagementListController>(
      () => ServiceManagementListController(
        Get.find<ServiceManagementRepositoryContract>(),
      ),
    );
  }
}
