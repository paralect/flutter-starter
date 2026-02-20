import 'package:mix/mix.dart';

enum AppTextStyleTokens {
  headline1('headline1'),
  headline2('headline2'),
  headline3('headline3'),
  headline4('headline4'),
  bodyLarge('body-large'),
  body('body'),
  bodySmall('body-small'),
  button('button'),
  caption('caption'),
  label('label'),
  overline('overline');

  const AppTextStyleTokens(this.name);
  final String name;

  TextStyleToken get token => TextStyleToken(name);
}
