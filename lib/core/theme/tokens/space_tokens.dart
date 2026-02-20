import 'package:mix/mix.dart';

enum AppSpaceTokens {
  xs('xs'),
  small('small'),
  medium('medium'),
  large('large'),
  xl('xl'),
  xxl('xxl');

  const AppSpaceTokens(this.name);
  final String name;

  SpaceToken get token => SpaceToken(name);
}
