import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryLight = Color(0xFF262626);
  static const Color onPrimaryLight = Color(0xFFFAFAFA);
  static const Color secondaryLight = Color(0xFFF5F5F5);
  static const Color onSecondaryLight = Color(0xFF262626);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color onSurfaceLight = Color(0xFF171717);
  static const Color onSurfaceVariantLight = Color(0xFF737373);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF171717);
  static const Color errorLight = Color(0xFFDC2626);
  static const Color onErrorLight = Color(0xFFFAFAFA);
  static const Color successLight = Color(0xFF22C55E);
  static const Color onSuccessLight = Color(0xFFFAFAFA);
  static const Color warningLight = Color(0xFFF59E0B);
  static const Color onWarningLight = Color(0xFFFAFAFA);
  static const Color outlineLight = Color(0xFFE5E5E5);
  static const Color outlineVariantLight = Color(0xFFF5F5F5);

  static const Color primaryDark = Color(0xFFE5E5E5);
  static const Color onPrimaryDark = Color(0xFF262626);
  static const Color secondaryDark = Color(0xFF404040);
  static const Color onSecondaryDark = Color(0xFFFAFAFA);
  static const Color surfaceDark = Color(0xFF262626);
  static const Color onSurfaceDark = Color(0xFFFAFAFA);
  static const Color onSurfaceVariantDark = Color(0xFFA3A3A3);
  static const Color backgroundDark = Color(0xFF171717);
  static const Color onBackgroundDark = Color(0xFFFAFAFA);
  static const Color errorDark = Color(0xFFF87171);
  static const Color onErrorDark = Color(0xFFFAFAFA);
  static const Color successDark = Color(0xFF4ADE80);
  static const Color onSuccessDark = Color(0xFF052E16);
  static const Color warningDark = Color(0xFFFBBF24);
  static const Color onWarningDark = Color(0xFF451A03);
  static const Color outlineDark = Color(0xFF404040);
  static const Color outlineVariantDark = Color(0xFF404040);

  static Color getPrimary(bool isDark) => isDark ? primaryDark : primaryLight;
  static Color getSecondary(bool isDark) =>
      isDark ? secondaryDark : secondaryLight;
  static Color getSuccess(bool isDark) => isDark ? successDark : successLight;
  static Color getWarning(bool isDark) => isDark ? warningDark : warningLight;
  static Color getError(bool isDark) => isDark ? errorDark : errorLight;
}
