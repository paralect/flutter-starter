import 'package:mix/mix.dart';

enum AppColorTokens {
  primary('primary'),
  onPrimary('on-primary'),
  secondary('secondary'),
  onSecondary('on-secondary'),
  surface('surface'),
  onSurface('on-surface'),
  onSurfaceVariant('on-surface-variant'),
  background('background'),
  onBackground('on-background'),
  error('error'),
  onError('on-error'),
  success('success'),
  onSuccess('on-success'),
  warning('warning'),
  onWarning('on-warning'),
  outline('outline'),
  outlineVariant('outline-variant');

  const AppColorTokens(this.name);
  final String name;

  ColorToken get token => ColorToken(name);
}
