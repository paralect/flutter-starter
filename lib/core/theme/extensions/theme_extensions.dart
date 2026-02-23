import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

import 'package:ship_flutter_starter/core/theme/tokens/colors.dart';

extension ShadThemeExtensions on BuildContext {
  shadcn.ThemeData get shadTheme => shadcn.Theme.of(this);

  shadcn.ColorScheme get shadColorScheme => shadTheme.colorScheme;

  Color get successColor =>
      shadTheme.brightness == Brightness.dark
          ? AppColors.successDark
          : AppColors.successLight;

  Color get warningColor =>
      shadTheme.brightness == Brightness.dark
          ? AppColors.warningDark
          : AppColors.warningLight;

  Color get errorColor =>
      shadTheme.brightness == Brightness.dark
          ? AppColors.errorDark
          : AppColors.errorLight;
}
