import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import '../tokens/color_tokens.dart';
import '../tokens/radius_tokens.dart';
import '../tokens/space_tokens.dart';
import '../tokens/text_style_tokens.dart';

class AppTheme {
  static Map<ColorToken, Color> get lightColors => {
        AppColorTokens.primary.token: const Color(0xFF0093B9),
        AppColorTokens.onPrimary.token: const Color(0xFFFFFFFF),
        AppColorTokens.secondary.token: const Color(0xFF617AFA),
        AppColorTokens.onSecondary.token: const Color(0xFFFFFFFF),
        AppColorTokens.surface.token: const Color(0xFFFFFFFF),
        AppColorTokens.onSurface.token: const Color(0xFF141C24),
        AppColorTokens.onSurfaceVariant.token: const Color(0xFF405473),
        AppColorTokens.background.token: const Color(0xFFFAFAFA),
        AppColorTokens.onBackground.token: const Color(0xFF141C24),
        AppColorTokens.error.token: const Color(0xFFB3261E),
        AppColorTokens.onError.token: const Color(0xFFFFFFFF),
        AppColorTokens.success.token: const Color(0xFF4CAF50),
        AppColorTokens.onSuccess.token: const Color(0xFFFFFFFF),
        AppColorTokens.warning.token: const Color(0xFFFF9800),
        AppColorTokens.onWarning.token: const Color(0xFFFFFFFF),
        AppColorTokens.outline.token: const Color(0xFF79747E),
        AppColorTokens.outlineVariant.token: const Color(0xFFCAC4D0),
      };

  static Map<ColorToken, Color> get darkColors => {
        AppColorTokens.primary.token: const Color(0xFF617AFA),
        AppColorTokens.onPrimary.token: const Color(0xFFFFFFFF),
        AppColorTokens.secondary.token: const Color(0xFF0093B9),
        AppColorTokens.onSecondary.token: const Color(0xFFFFFFFF),
        AppColorTokens.surface.token: const Color(0xFF1C1C21),
        AppColorTokens.onSurface.token: const Color(0xFFE6E1E5),
        AppColorTokens.onSurfaceVariant.token: const Color(0xFFCAC4D0),
        AppColorTokens.background.token: const Color(0xFF141218),
        AppColorTokens.onBackground.token: const Color(0xFFE6E1E5),
        AppColorTokens.error.token: const Color(0xFFF2B8B5),
        AppColorTokens.onError.token: const Color(0xFF601410),
        AppColorTokens.success.token: const Color(0xFF81C784),
        AppColorTokens.onSuccess.token: const Color(0xFF1B5E20),
        AppColorTokens.warning.token: const Color(0xFFFFB74D),
        AppColorTokens.onWarning.token: const Color(0xFFE65100),
        AppColorTokens.outline.token: const Color(0xFF938F99),
        AppColorTokens.outlineVariant.token: const Color(0xFF49454F),
      };

  static Map<TextStyleToken, TextStyle> get lightTextStyles => {
        AppTextStyleTokens.headline1.token: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        AppTextStyleTokens.headline2.token: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        AppTextStyleTokens.headline3.token: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.3,
        ),
        AppTextStyleTokens.headline4.token: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          height: 1.4,
        ),
        AppTextStyleTokens.bodyLarge.token: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        AppTextStyleTokens.body.token: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.25,
          height: 1.5,
        ),
        AppTextStyleTokens.bodySmall.token: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4,
          height: 1.4,
        ),
        AppTextStyleTokens.button.token: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          height: 1.2,
        ),
        AppTextStyleTokens.caption.token: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4,
          height: 1.3,
        ),
        AppTextStyleTokens.label.token: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.3,
        ),
        AppTextStyleTokens.overline.token: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          height: 1.2,
        ),
      };

  static Map<TextStyleToken, TextStyle> get darkTextStyles =>
      lightTextStyles;

  static Map<RadiusToken, Radius> get radii => {
        AppRadiusTokens.small.token: const Radius.circular(4),
        AppRadiusTokens.medium.token: const Radius.circular(8),
        AppRadiusTokens.large.token: const Radius.circular(12),
        AppRadiusTokens.xl.token: const Radius.circular(16),
        AppRadiusTokens.full.token: const Radius.circular(9999),
      };

  static Map<SpaceToken, double> get spaces => {
        AppSpaceTokens.xs.token: 4,
        AppSpaceTokens.small.token: 8,
        AppSpaceTokens.medium.token: 16,
        AppSpaceTokens.large.token: 24,
        AppSpaceTokens.xl.token: 32,
        AppSpaceTokens.xxl.token: 48,
      };
}
