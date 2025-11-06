import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/staff_provider.dart';
import 'package:salonku/app/data/repositories/contract/staff_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/staff_repository_impl.dart';

import '../controllers/staff_list_controller.dart';

class StaffListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffProvider>(() => StaffProvider());
    Get.lazyPut<StaffRepositoryContract>(() => StaffRepositoryImpl());
    Get.lazyPut<StaffListController>(
      () => StaffListController(Get.find<StaffRepositoryContract>()),
    );
  }
}
