import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonku/app/common/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: AppColors.lightText,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimary,
      surface: AppColors.lightAccent,
    ),
    textTheme: GoogleFonts.quicksandTextTheme(
      TextTheme(bodyMedium: TextStyle(color: AppColors.lightText)),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.darkText,
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      surface: AppColors.darkAccent,
    ),
    textTheme: GoogleFonts.quicksandTextTheme(
      TextTheme(bodyMedium: TextStyle(color: AppColors.darkText)),
    ),
  );
}
