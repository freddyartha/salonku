import 'package:get/get.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/providers/local/local_data_source_impl.dart';
import 'package:salonku/app/data/repositories/contract/supplier_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/supplier_repository_impl.dart';

import '../controllers/supplier_setup_controller.dart';

class SupplierSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupplierRepositoryContract>(() => SupplierRepositoryImpl());
    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl());
    Get.lazyPut<SupplierSetupController>(
      () => SupplierSetupController(
        Get.find<SupplierRepositoryContract>(),
        Get.find<LocalDataSource>(),
      ),
    );
  }
}
