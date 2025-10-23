import 'package:get/get.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/providers/local/local_data_source_impl.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/salon_repository_impl.dart';

import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalonRepositoryContract>(() => SalonRepositoryImpl());
    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl());
    Get.lazyPut<SettingsController>(
      () => SettingsController(
        Get.find<SalonRepositoryContract>(),
        Get.find<LocalDataSource>(),
      ),
    );
  }
}
