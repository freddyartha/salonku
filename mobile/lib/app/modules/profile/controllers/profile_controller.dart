import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/core/base/theme_controller.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final ThemeController themeController = ThemeController.instance;
  final List<MenuItemModel> menuItemList = [];

  @override
  void onInit() {
    menuItemList.addAll([
      MenuItemModel(
        title: "change_mode".tr,
        id: 1,
        imageLocation: themeController.themeMode.value == ThemeMode.dark
            ? "assets/images/png/dark_mode.png"
            : "assets/images/png/light_mode.png",
        onTab: themeController.toggleTheme,
      ),
      MenuItemModel(
        id: 2,
        title: "change_language".tr,
        imageLocation: "assets/images/png/language.png",
        onTab: () => Get.toNamed(Routes.PROFILE_CHANGE_LANGUAGE),
      ),
    ]);
    super.onInit();
  }
}
