import 'package:get/get.dart';

import '../controllers/owner_approval_controller.dart';

class OwnerApprovalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerApprovalController>(() => OwnerApprovalController());
  }
}
