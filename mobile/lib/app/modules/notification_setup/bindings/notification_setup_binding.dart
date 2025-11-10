import 'package:get/get.dart';

import '../controllers/notification_setup_controller.dart';

class NotificationSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationSetupController>(
      () => NotificationSetupController(),
    );
  }
}
