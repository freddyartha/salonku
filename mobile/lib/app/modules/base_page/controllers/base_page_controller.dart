import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/booking_provider.dart';
import 'package:salonku/app/data/repositories/contract/booking_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/booking_repository_impl.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/modules/home/controllers/home_controller.dart';
import 'package:salonku/app/modules/home/views/home_view.dart';
import 'package:salonku/app/modules/notification_list/views/notification_list_view.dart';
import 'package:salonku/app/modules/profile/controllers/profile_controller.dart';
import 'package:salonku/app/modules/profile/views/profile_view.dart';
import 'package:salonku/app/modules/schedule_calendar/controllers/schedule_calendar_controller.dart';
import 'package:salonku/app/modules/schedule_calendar/views/schedule_calendar_view.dart';
import 'package:salonku/app/modules/settings/controllers/settings_controller.dart';
import 'package:salonku/app/modules/settings/views/settings_view.dart';

class BasePageController extends GetxController {
  final List<MenuItemModel> menuItemList = [
    MenuItemModel(id: 0, imageLocation: "assets/images/png/home.png"),
    MenuItemModel(id: 1, imageLocation: "assets/images/png/settings.png"),
    MenuItemModel(id: 2, imageLocation: "assets/images/png/calendar.png"),
    MenuItemModel(id: 3, imageLocation: "assets/images/png/bell.png"),
    MenuItemModel(id: 4, imageLocation: "assets/images/png/user.png"),
  ];
  RxInt selectedId = 0.obs;

  final List<Widget Function()> pages = [
    () => const HomeView(),
    () => const SettingsView(),
    () => const ScheduleCalendarView(),
    () => const NotificationListView(),
    () => const ProfileView(),
  ];

  final SettingsController settingController =
      Get.isRegistered<SettingsController>()
      ? Get.find<SettingsController>()
      : Get.put(SettingsController());
  final HomeController homeController = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());
  final ProfileController profileController =
      Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  final scheduleProvider = Get.lazyPut<BookingProvider>(
    () => BookingProvider(),
  );
  final scheduleRepository = Get.lazyPut<BookingRepositoryContract>(
    () => BookingRepositoryImpl(),
  );
  final ScheduleCalendarController scheduleController =
      Get.isRegistered<ScheduleCalendarController>()
      ? Get.find<ScheduleCalendarController>()
      : Get.put(
          ScheduleCalendarController(Get.find<BookingRepositoryContract>()),
        );

  void itemOnTap(int id) {
    selectedId.value = id;
    if (selectedId.value == 1) {
      settingController.getSalonSummary();
    }
    if (selectedId.value == 2) {
      scheduleController.getBookingByUserId();
    }
  }
}
