import 'package:get/get.dart';
import 'package:salonku/app/common/lang/translation_service.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';

class ProfileChangeLanguageController extends GetxController {
  final pilihBahasaCon = InputRadioController(
    items: [
      RadioButtonItem(
        text: "Bahasa Indonesia (ID)",
        value: 1,
        pngUrl: "assets/images/png/language.png",
      ),
      RadioButtonItem(
        text: "English (EN)",
        value: 2,
        pngUrl: "assets/images/png/language.png",
      ),
    ],
  );

  int currentSelectedLanguage = 1;

  @override
  void onInit() {
    if (TranslationService.locale.languageCode == 'id') {
      pilihBahasaCon.value = 1;
    } else if (TranslationService.locale.languageCode == 'en') {
      pilihBahasaCon.value = 2;
    }
    currentSelectedLanguage = pilihBahasaCon.value;
    pilihBahasaCon.onChanged = (item) async {
      if (item.value != currentSelectedLanguage) {
        // bool? konfirmasiBahasa = await ReusableWidgets.confirmationBottomSheet(
        //   title: "title_change_language".tr,
        //   children: [
        //     TextComponent(
        //       value: "confirm_change_language".tr,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ],
        // );
        // if (konfirmasiBahasa == true) {
        currentSelectedLanguage = item.value;
        if (item.value == 1) {
          // Get.updateLocale(Locale('id', 'ID'));
          TranslationService.changeLocale("id");
          pilihBahasaCon.value = item.value;
        } else if (item.value == 2) {
          // Get.updateLocale(Locale('en', 'EN'));
          TranslationService.changeLocale("en");
          pilihBahasaCon.value = item.value;
        }

        // } else if (konfirmasiBahasa == false) {
        //   pilihBahasaCon.value = currentSelectedLanguage;
        // }
      }
    };
    super.onInit();
  }
}
