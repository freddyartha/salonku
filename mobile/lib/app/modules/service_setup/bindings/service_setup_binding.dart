import 'package:get/get.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/providers/local/local_data_source_impl.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/salon_repository_impl.dart';
import 'package:salonku/app/data/repositories/implementation/service_repository_impl.dart';

import '../controllers/service_setup_controller.dart';

class ServiceSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalonRepositoryContract>(() => SalonRepositoryImpl());
    Get.lazyPut<ServiceRepositoryContract>(() => ServiceRepositoryImpl());
    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl());
    Get.lazyPut<ServiceSetupController>(
      () => ServiceSetupController(
        Get.find<SalonRepositoryContract>(),
        Get.find<ServiceRepositoryContract>(),
        Get.find<LocalDataSource>(),
      ),
    );
  }
}
