import '../enums/app_environment.dart';

class AppConfig {
  static AppEnvironment _environment = AppEnvironment.development;

  static AppEnvironment get environment => _environment;

  static String get apiUrl => _environment.apiUrl;

  static void setEnvironment(AppEnvironment env) {
    _environment = env;
  }

  static bool get isDevelopment => _environment.isDevelopment;
  static bool get isProduction => _environment.isProduction;
}
