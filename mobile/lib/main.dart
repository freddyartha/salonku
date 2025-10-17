import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/app_themes.dart';
import 'package:salonku/app/common/lang/translation_service.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/config/environment.dart';
import 'package:salonku/app/config/initial_binding.dart';
import 'package:salonku/app/core/controllers/theme_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);

  //load env
  await EnvironmentConfig.init();

  //init get storage
  await GetStorage.init();

  await Firebase.initializeApp();

  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 60
    ..contentPadding = EdgeInsets.all(10)
    ..progressColor = AppColors.darkContrast
    ..backgroundColor = Colors.white
    ..indicatorColor = AppColors.darkContrast
    ..textColor = AppColors.darkContrast
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = true
    ..lineWidth = 6
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..radius = Radiuses.large
    ..dismissOnTap = true;

  runApp(
    GetX<ThemeController>(
      init: ThemeController(),
      builder: (themeController) {
        return GetMaterialApp(
          title: "app_name".tr,
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
          builder: EasyLoading.init(),
        );
      },
    ),
  );
}
