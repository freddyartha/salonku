import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile/app/common/lang/translation_service.dart';
import 'package:mobile/app/config/environment.dart';
import 'package:mobile/app/config/initial_binding.dart';

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
  runApp(
    GetMaterialApp(
      title: "SalonKu",
      theme: ThemeData(
        textTheme: GoogleFonts.quicksandTextTheme(ThemeData.light().textTheme),
        scaffoldBackgroundColor: Colors.white,
        listTileTheme: ListTileThemeData(tileColor: Colors.white),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: TranslationService.locale,
      translations: TranslationService(),
      fallbackLocale: TranslationService.locale,
      debugShowCheckedModeBanner: EnvironmentConfig.enableDebugMode,
      initialBinding: InitialBinding(),
      // builder: EasyLoading.init(),
    ),
  );
}
