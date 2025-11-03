import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/product_provider.dart';
import 'package:salonku/app/data/providers/api/supplier_provider.dart';
import 'package:salonku/app/data/repositories/contract/product_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/supplier_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/product_repository_impl.dart';
import 'package:salonku/app/data/repositories/implementation/supplier_repository_impl.dart';

import '../controllers/product_setup_controller.dart';

class ProductSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductProvider>(() => ProductProvider());
    Get.lazyPut<SupplierProvider>(() => SupplierProvider());
    Get.lazyPut<ProductRepositoryContract>(() => ProductRepositoryImpl());
    Get.lazyPut<SupplierRepositoryContract>(() => SupplierRepositoryImpl());
    Get.lazyPut<ProductSetupController>(
      () => ProductSetupController(
        Get.find<ProductRepositoryContract>(),
        Get.find<SupplierRepositoryContract>(),
      ),
    );
  }
}
