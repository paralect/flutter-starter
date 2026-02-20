import 'package:mix/mix.dart';

enum AppRadiusTokens {
  small('small'),
  medium('medium'),
  large('large'),
  xl('xl'),
  full('full');

  const AppRadiusTokens(this.name);
  final String name;

  RadiusToken get token => RadiusToken(name);
}
