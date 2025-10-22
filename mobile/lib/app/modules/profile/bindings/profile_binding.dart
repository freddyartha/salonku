import 'package:get/get.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/providers/local/local_data_source_impl.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl());
    Get.lazyPut<ProfileController>(
      () => ProfileController(Get.find<LocalDataSource>()),
    );
  }
}
