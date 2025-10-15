import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salonku/app/core/constants/storage_key.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.isRegistered<ThemeController>()
      ? Get.find<ThemeController>()
      : Get.put(ThemeController());
  final _box = GetStorage();
  final themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    final String? savedThemeMode = _box.read(StorageKey.cachedThemeKey);
    if (savedThemeMode == "dark") {
      themeMode.value = ThemeMode.dark;
    } else if (savedThemeMode == "light") {
      themeMode.value = ThemeMode.light;
    } else {
      themeMode.value = ThemeMode.system;
    }
  }

  void toggleTheme(ThemeMode selectedTheme) {
    themeMode.value = selectedTheme;
    Get.changeThemeMode(themeMode.value);
    _box.write(StorageKey.cachedThemeKey, themeMode.value.name);
  }

  // // AppColorsModel getAppColors(BuildContext context) {
  // AppColorsModel getAppColors() {
  //   final brightness = MediaQuery.of(Get.context!).platformBrightness;
  //   AppColorsModel lightColors = AppColorsModel(
  //     primary: AppColors.lightPrimary,
  //     accent: AppColors.lightAccent,
  //     accent2: AppColors.lightAccent2,
  //     contrast: AppColors.lightContrast,
  //     text: AppColors.lightText,
  //   );
  //   AppColorsModel darkColors = AppColorsModel(
  //     primary: AppColors.darkPrimary,
  //     accent: AppColors.darkAccent,
  //     accent2: AppColors.darkAccent2,
  //     contrast: AppColors.darkContrast,
  //     text: AppColors.darkText,
  //   );

  //   if (themeMode.value == ThemeMode.system) {
  //     if (brightness == Brightness.dark) {
  //       return darkColors;
  //     } else {
  //       return lightColors;
  //     }
  //   } else if (themeMode.value == ThemeMode.dark) {
  //     return darkColors;
  //   } else {
  //     return lightColors;
  //   }
  // }
}
