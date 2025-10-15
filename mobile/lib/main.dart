import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salonku/app/common/app_themes.dart';
import 'package:salonku/app/common/lang/translation_service.dart';
import 'package:salonku/app/config/environment.dart';
import 'package:salonku/app/config/initial_binding.dart';
import 'package:salonku/app/core/controllers/auth_controller.dart';
import 'package:salonku/app/core/controllers/theme_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  //load env
  await EnvironmentConfig.init();
  //init get storage
  await GetStorage.init();
  //easyloading
  // configLoading();
  await Firebase.initializeApp();
  AuthController.instance;
  runApp(
    GetX<ThemeController>(
      init: ThemeController(),
      builder: (themeController) {
        return GetMaterialApp(
          title: "SalonKu",
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeController.themeMode.value,
          locale: TranslationService.locale,
          translations: TranslationService(),
          fallbackLocale: TranslationService.fallBackLocale,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBinding(),
        );
      },
    ),
  );
}
