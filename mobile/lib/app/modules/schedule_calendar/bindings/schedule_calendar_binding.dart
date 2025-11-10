import 'package:get/get.dart';

import '../controllers/schedule_calendar_controller.dart';

class ScheduleCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleCalendarController>(
      () => ScheduleCalendarController(),
    );
  }
}
