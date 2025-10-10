import 'package:flutter/material.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/core/base/theme_controller.dart';
import 'package:uuid/uuid.dart';

enum Penilaian { empty, buruk, baik, luarBiasa }

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

  static Widget imageErrorBuilder = Image.asset(
    'packages/gawat_darurat/assets/png/not_found.png',
  );

  static RefreshIndicator refreshIndicator({
    required Future<void> Function() onRefresh,
    required Widget child,
  }) => RefreshIndicator(
    color: ThemeController.instance.themeMode.value == ThemeMode.light
        ? AppColors.lightPrimary
        : AppColors.darkPrimary,
    backgroundColor: ThemeController.instance.themeMode.value == ThemeMode.light
        ? AppColors.lightContrast
        : AppColors.darkContrast,
    onRefresh: onRefresh,
    child: child,
  );

  static String getPenilaianLocalImage(Penilaian penilaian) {
    switch (penilaian) {
      case Penilaian.empty:
        return "";
      case Penilaian.buruk:
        return 'packages/gawat_darurat/assets/png/buruk.png';
      case Penilaian.baik:
        return 'packages/gawat_darurat/assets/png/baik.png';
      case Penilaian.luarBiasa:
        return 'packages/gawat_darurat/assets/png/luar_biasa.png';
    }
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
}
