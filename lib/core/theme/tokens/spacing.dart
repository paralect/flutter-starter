import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static EdgeInsets get paddingXs => const EdgeInsets.all(xs);
  static EdgeInsets get paddingSmall => const EdgeInsets.all(small);
  static EdgeInsets get paddingMedium => const EdgeInsets.all(medium);
  static EdgeInsets get paddingLarge => const EdgeInsets.all(large);
  static EdgeInsets get paddingXl => const EdgeInsets.all(xl);
  static EdgeInsets get paddingXxl => const EdgeInsets.all(xxl);
}
