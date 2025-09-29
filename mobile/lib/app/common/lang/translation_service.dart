import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'en_us.dart';
import 'id_id.dart';

class TranslationService extends Translations {
  static Locale get locale {
    String? localeCode = GetStorage().read("locale");
    if (localeCode != null && localeCode == "id") {
      return Locale(localeCode, localeCode.toUpperCase());
    } else if (localeCode != null && localeCode == "en") {
      return Locale(localeCode, localeCode.toUpperCase());
    } else {
      return Get.deviceLocale ?? const Locale("id", "ID");
    }
  }

  // static Locale? get locale => const Locale("id", "ID");
  static const feedBackLocale = Locale("id", "ID");

  Map<String, String> mergedIdLang = {...idID};
  Map<String, String> mergedEnLang = {...enUS};

  @override
  Map<String, Map<String, String>> get keys => {
    "id_ID": mergedIdLang,
    "en_US": mergedEnLang,
  };

  static void changeLocale(String langCode) {
    final locale = Locale(langCode, langCode.toUpperCase());
    Get.updateLocale(locale);
  }
}
