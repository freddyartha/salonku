import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salonku/app/common/lang/en_us.dart';
import 'package:salonku/app/common/lang/id_id.dart';
import 'package:salonku/app/core/core.dart';

class TranslationService extends Translations {
  static final _box = GetStorage();
  static final localeId = Locale("id", "ID");
  static final localeEn = Locale("en", "US");

  static Locale get locale {
    String? localeCode = _box.read(StorageKey.cachedLocaleKey);
    if (localeCode != null && localeCode == "id") {
      return localeId;
    } else if (localeCode != null && localeCode == "en") {
      return localeEn;
    } else {
      return Get.deviceLocale ?? localeId;
    }
  }

  static final fallBackLocale = Get.deviceLocale ?? localeId;

  @override
  Map<String, Map<String, String>> get keys => {"id_ID": idID, "en_US": enUS};

  static void changeLocale(Locale locale) {
    Get.updateLocale(locale);
    _box.write(StorageKey.cachedLocaleKey, locale.languageCode);
  }
}
