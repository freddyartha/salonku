import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/extension/theme_extension.dart';
import 'package:salonku/app/models/user_model.dart';
import 'package:uuid/uuid.dart';

class ReusableStatics {
  static double appBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top + kToolbarHeight;

  static RoundedRectangleBorder cardBorderShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Radiuses.regular),
  );

  static String idGenerator() {
    const uuid = Uuid();
    var r = uuid.v8();
    return r;
  }

  static Gradient normalGradientColor = LinearGradient(
    colors: [Color(0xFFb21e35), Color(0xFFc9184a), Color(0xFFfae0e4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static RefreshIndicator refreshIndicator({
    required Future<void> Function() onRefresh,
    required Widget child,
  }) => RefreshIndicator(
    color: Get.context?.primary,
    backgroundColor: Get.context?.contrast,
    onRefresh: onRefresh,
    child: child,
  );

  static String getLevelUser(int level) {
    String val = "";
    if (level == 1) {
      val = "Salon Owner";
    } else if (level == 2) {
      val = "Staff Salon";
    } else if (level == 3) {
      val = "Co-Owner";
    }
    return val;
  }

  static Color getColorFromDynamic(dynamic dynamicColor, Color fallbackColor) {
    int? value;
    if (dynamicColor == null || dynamicColor == "") {
      return fallbackColor;
    } else if (dynamicColor.contains("#")) {
      value = int.tryParse(dynamicColor.replaceAll("#", "0XFF"));
    } else {
      value = int.tryParse(dynamicColor);
    }
    return value != null ? Color(value) : fallbackColor;
  }

  static CurrencyPickerThemeData currencyPickerTheme() =>
      CurrencyPickerThemeData(
        backgroundColor: Get.context?.accent2,
        bottomSheetHeight: Get.height * 0.7,
        titleTextStyle: TextStyle(color: Get.context?.text),
        currencySignTextStyle: TextStyle(color: Get.context?.text),
        subtitleTextStyle: TextStyle(color: Get.context?.text),
        inputDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          prefixIcon: Icon(Icons.search),
          label: TextComponent(value: "currency_hint".tr),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Radiuses.large),
            borderSide: BorderSide(
              color: Get.context?.contrast ?? AppColors.darkContrast,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Radiuses.large),
            borderSide: BorderSide(
              color: Get.context?.contrast ?? AppColors.darkContrast,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Radiuses.large),
            borderSide: BorderSide(
              color: Get.context?.contrast ?? AppColors.darkContrast,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Radiuses.large),
            borderSide: BorderSide(
              color: Get.context?.contrast ?? AppColors.darkContrast,
            ),
          ),
        ),
      );

  static List<RadioButtonItem> jenisKelaminRadioItem = [
    RadioButtonItem(text: "male".tr, value: "l"),
    RadioButtonItem(text: "female".tr, value: "p"),
  ];

  static bool checkIsUserStaffWithCabang(UserModel userModel) {
    if (userModel.level == 2 &&
        userModel.cabangs != null &&
        userModel.cabangs!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static bool userIsStaff(UserModel userModel) {
    if (userModel.level == 2) {
      return true;
    } else {
      return false;
    }
  }

  static DateTime lastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }
}
