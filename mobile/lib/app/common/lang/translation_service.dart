import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salonku/app/common/lang/en_us.dart';
import 'package:salonku/app/common/lang/id_id.dart';
import 'package:salonku/app/core/core.dart';

class TranslationService extends Translations {
  static final _box = GetStorage();
  static Locale get locale {
    String? localeCode = _box.read(StorageKey.cachedLocaleKey);
    if (localeCode != null && localeCode == "id") {
      return Locale(localeCode, localeCode.toUpperCase());
    } else if (localeCode != null && localeCode == "en") {
      return Locale(localeCode, localeCode.toUpperCase());
    } else {
      return Get.deviceLocale ?? const Locale("id", "ID");
    }
  }

  static final fallBackLocale = Get.deviceLocale ?? const Locale("id", "ID");

  @override
  Map<String, Map<String, String>> get keys => {"id_ID": idID, "en_US": enUS};

  static void changeLocale(String langCode) {
    final locale = Locale(langCode, langCode.toUpperCase());
    Get.updateLocale(locale);
    _box.write(StorageKey.cachedLocaleKey, langCode);
  }
}
