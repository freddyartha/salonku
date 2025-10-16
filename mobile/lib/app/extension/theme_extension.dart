import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  /// Shortcut untuk Theme.of(context)
  ThemeData get theme => Theme.of(this);

  /// Shortcut untuk ColorScheme
  ColorScheme get color => theme.colorScheme;

  /// Shortcut untuk brightness (light/dark)
  Brightness get brightness => theme.brightness;

  /// True jika tema sekarang dark
  bool get isDark => brightness == Brightness.dark;

  /// True jika tema sekarang light
  bool get isLight => brightness == Brightness.light;

  /// Warna
  Color get primary => theme.scaffoldBackgroundColor;
  Color get accent => color.secondary;
  Color get accent2 => color.surface;
  Color get contrast => color.primary;
  Color get text => color.onSurface;
}
