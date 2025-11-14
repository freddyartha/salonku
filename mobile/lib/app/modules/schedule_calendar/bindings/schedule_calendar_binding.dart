import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/booking_provider.dart';
import 'package:salonku/app/data/repositories/contract/booking_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/booking_repository_impl.dart';

import '../controllers/schedule_calendar_controller.dart';

class ScheduleCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingProvider>(() => BookingProvider());
    Get.lazyPut<BookingRepositoryContract>(() => BookingRepositoryImpl());
    Get.lazyPut<ScheduleCalendarController>(
      () => ScheduleCalendarController(Get.find<BookingRepositoryContract>()),
    );
  }
}
