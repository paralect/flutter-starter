import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

import 'package:ship_flutter_starter/core/theme/tokens/colors.dart';

class AppColorSchemes {
  AppColorSchemes._();

  static const shadcn.ColorScheme light = shadcn.ColorScheme(
    brightness: Brightness.light,
    background: AppColors.backgroundLight,
    foreground: AppColors.onBackgroundLight,
    card: AppColors.surfaceLight,
    cardForeground: AppColors.onSurfaceLight,
    popover: AppColors.surfaceLight,
    popoverForeground: AppColors.onSurfaceLight,
    primary: AppColors.primaryLight,
    primaryForeground: AppColors.onPrimaryLight,
    secondary: AppColors.secondaryLight,
    secondaryForeground: AppColors.onSecondaryLight,
    muted: AppColors.outlineVariantLight,
    mutedForeground: AppColors.onSurfaceVariantLight,
    accent: AppColors.outlineVariantLight,
    accentForeground: AppColors.onSurfaceLight,
    destructive: AppColors.errorLight,
    border: AppColors.outlineVariantLight,
    input: AppColors.outlineLight,
    ring: AppColors.primaryLight,
    chart1: Color(0xFFE76E50),
    chart2: Color(0xFF14B8A6),
    chart3: Color(0xFF3B82F6),
    chart4: Color(0xFFFBBF24),
    chart5: Color(0xFFF97316),
  );

  static const shadcn.ColorScheme dark = shadcn.ColorScheme(
    brightness: Brightness.dark,
    background: AppColors.backgroundDark,
    foreground: AppColors.onBackgroundDark,
    card: AppColors.surfaceDark,
    cardForeground: AppColors.onSurfaceDark,
    popover: AppColors.surfaceDark,
    popoverForeground: AppColors.onSurfaceDark,
    primary: AppColors.primaryDark,
    primaryForeground: AppColors.onPrimaryDark,
    secondary: AppColors.secondaryDark,
    secondaryForeground: AppColors.onSecondaryDark,
    muted: AppColors.outlineVariantDark,
    mutedForeground: AppColors.onSurfaceVariantDark,
    accent: AppColors.outlineVariantDark,
    accentForeground: AppColors.onSurfaceDark,
    destructive: AppColors.errorDark,
    border: AppColors.outlineVariantDark,
    input: AppColors.outlineDark,
    ring: AppColors.primaryDark,
    chart1: Color(0xFF6366F1),
    chart2: Color(0xFF2DD4BF),
    chart3: Color(0xFFF97316),
    chart4: Color(0xFFA855F7),
    chart5: Color(0xFFF43F5E),
  );
}
