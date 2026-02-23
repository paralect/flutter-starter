import 'package:flutter/material.dart';

enum AppTextStyleToken {
  headline1,
  headline2,
  headline3,
  headline4,
  bodyLarge,
  body,
  bodySmall,
  button,
  caption,
  label,
  overline,
}

extension AppTextStyleTokenExtension on AppTextStyleToken {
  TextStyle style(TextStyle base) {
    return switch (this) {
      AppTextStyleToken.headline1 => base.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          height: 1.2,
        ),
      AppTextStyleToken.headline2 => base.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          height: 1.2,
        ),
      AppTextStyleToken.headline3 => base.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.3,
        ),
      AppTextStyleToken.headline4 => base.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          height: 1.4,
        ),
      AppTextStyleToken.bodyLarge => base.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.5,
          height: 1.5,
        ),
      AppTextStyleToken.body => base.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.25,
          height: 1.5,
        ),
      AppTextStyleToken.bodySmall => base.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4,
          height: 1.4,
        ),
      AppTextStyleToken.button => base.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          height: 1.2,
        ),
      AppTextStyleToken.caption => base.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4,
          height: 1.3,
        ),
      AppTextStyleToken.label => base.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.3,
        ),
      AppTextStyleToken.overline => base.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          height: 1.2,
        ),
    };
  }
}
