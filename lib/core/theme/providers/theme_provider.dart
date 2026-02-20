import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mix/mix.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../themes/app_theme.dart';

part 'theme_provider.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  bool build() => false;

  void toggleTheme() {
    state = !state;
  }

  void setDarkMode(bool isDark) {
    state = isDark;
  }
}

@riverpod
Map<ColorToken, Color> appColors(Ref ref) {
  final isDark = ref.watch(appThemeModeProvider);
  return isDark ? AppTheme.darkColors : AppTheme.lightColors;
}

@riverpod
Map<TextStyleToken, TextStyle> appTextStyles(Ref ref) {
  final isDark = ref.watch(appThemeModeProvider);
  return isDark ? AppTheme.darkTextStyles : AppTheme.lightTextStyles;
}

@riverpod
Map<RadiusToken, Radius> appRadii(Ref ref) {
  return AppTheme.radii;
}

@riverpod
Map<SpaceToken, double> appSpaces(Ref ref) {
  return AppTheme.spaces;
}
