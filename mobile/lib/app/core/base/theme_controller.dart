import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.isRegistered<ThemeController>()
      ? Get.find<ThemeController>()
      : Get.put(ThemeController());
  final _box = GetStorage();
  final themeMode = ThemeMode.light.obs;

  @override
  void onInit() {
    super.onInit();
    final isDark = _box.read('isDarkMode') ?? false;
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
      _box.write('isDarkMode', true);
    } else {
      themeMode.value = ThemeMode.light;
      _box.write('isDarkMode', false);
    }
  }
}
