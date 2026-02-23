import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'package:ship_flutter_starter/core/theme/themes/app_theme.dart';

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
ThemeData appTheme(Ref ref) {
  final isDark = ref.watch(appThemeModeProvider);
  return isDark ? AppTheme.dark : AppTheme.light;
}

@riverpod
ThemeMode appThemeModeValue(Ref ref) {
  final isDark = ref.watch(appThemeModeProvider);
  return isDark ? ThemeMode.dark : ThemeMode.light;
}
