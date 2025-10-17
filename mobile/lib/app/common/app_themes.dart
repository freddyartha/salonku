import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonku/app/common/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightContrast,
      secondary: AppColors.lightAccent,
      surface: AppColors.lightAccent2,
      surfaceBright: AppColors.lightContrast,
      onSurface: AppColors.lightText,
      surfaceDim: AppColors.lightAccent2,
    ),
    scaffoldBackgroundColor: AppColors.lightPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightAccent,
      foregroundColor: AppColors.lightText,
      elevation: 0,
    ),
    textTheme: GoogleFonts.quicksandTextTheme(
      TextTheme(bodyMedium: TextStyle(color: AppColors.lightText)),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.lightContrast,
      secondary: AppColors.darkAccent,
      surface: AppColors.darkAccent2,
      surfaceBright: AppColors.darkContrast,
      onSurface: AppColors.darkText,
      surfaceDim: AppColors.darkAccent2,
    ),
    scaffoldBackgroundColor: AppColors.darkPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkAccent,
      foregroundColor: AppColors.darkText,
      elevation: 0,
    ),
    textTheme: GoogleFonts.quicksandTextTheme(
      TextTheme(bodyMedium: TextStyle(color: AppColors.lightText)),
    ),
  );
}
