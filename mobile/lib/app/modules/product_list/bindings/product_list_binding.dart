import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/product_provider.dart';
import 'package:salonku/app/data/repositories/contract/product_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/product_repository_impl.dart';

import '../controllers/product_list_controller.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductProvider>(() => ProductProvider());
    Get.lazyPut<ProductRepositoryContract>(() => ProductRepositoryImpl());
    Get.lazyPut<ProductListController>(
      () => ProductListController(Get.find<ProductRepositoryContract>()),
    );
  }
}
