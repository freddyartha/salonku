import 'package:get/get.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/providers/local/local_data_source_impl.dart';
import 'package:salonku/app/data/repositories/contract/product_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/product_repository_impl.dart';

import '../controllers/product_setup_controller.dart';

class ProductSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepositoryContract>(() => ProductRepositoryImpl());
    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl());
    Get.lazyPut<ProductSetupController>(
      () => ProductSetupController(
        Get.find<ProductRepositoryContract>(),
        Get.find<LocalDataSource>(),
      ),
    );
  }
}
