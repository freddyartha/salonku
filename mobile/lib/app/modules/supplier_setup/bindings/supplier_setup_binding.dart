import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/supplier_provider.dart';
import 'package:salonku/app/data/repositories/contract/supplier_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/supplier_repository_impl.dart';

import '../controllers/supplier_setup_controller.dart';

class SupplierSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupplierProvider>(() => SupplierProvider());
    Get.lazyPut<SupplierRepositoryContract>(() => SupplierRepositoryImpl());
    Get.lazyPut<SupplierSetupController>(
      () => SupplierSetupController(Get.find<SupplierRepositoryContract>()),
    );
  }
}
