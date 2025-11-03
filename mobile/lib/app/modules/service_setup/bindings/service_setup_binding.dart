import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/service_provider.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/service_repository_impl.dart';

import '../controllers/service_setup_controller.dart';

class ServiceSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceProvider>(() => ServiceProvider());
    Get.lazyPut<ServiceRepositoryContract>(() => ServiceRepositoryImpl());
    Get.lazyPut<ServiceSetupController>(
      () => ServiceSetupController(Get.find<ServiceRepositoryContract>()),
    );
  }
}
