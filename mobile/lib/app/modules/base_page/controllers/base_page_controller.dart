import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/modules/home/controllers/home_controller.dart';
import 'package:salonku/app/modules/home/views/home_view.dart';
import 'package:salonku/app/modules/profile/controllers/profile_controller.dart';
import 'package:salonku/app/modules/profile/views/profile_view.dart';
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
    () => const ProfileView(),
    () => const ProfileView(),
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

  void itemOnTap(int id) {
    selectedId.value = id;
    if (selectedId.value == 1) {
      settingController.getSalonSummary();
    }
  }
}
