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
}
