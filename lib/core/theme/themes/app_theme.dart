import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

import 'color_schemes.dart';

class AppTheme {
  AppTheme._();

  static shadcn.ThemeData get light => shadcn.ThemeData(
        colorScheme: AppColorSchemes.light,
        radius: 0.5,
        scaling: 1,
      );

  static shadcn.ThemeData get dark => shadcn.ThemeData.dark(
        colorScheme: AppColorSchemes.dark,
        radius: 0.5,
        scaling: 1,
      );
}
