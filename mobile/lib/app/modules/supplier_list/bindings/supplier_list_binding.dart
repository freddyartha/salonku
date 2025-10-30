import 'package:get/get.dart';
import 'package:salonku/app/data/repositories/contract/supplier_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/supplier_repository_impl.dart';

import '../controllers/supplier_list_controller.dart';

class SupplierListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupplierRepositoryContract>(() => SupplierRepositoryImpl());
    Get.lazyPut<SupplierListController>(
      () => SupplierListController(Get.find<SupplierRepositoryContract>()),
    );
  }
}
