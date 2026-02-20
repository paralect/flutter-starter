enum AppEnvironment {
  development,
  staging,
  production;

  String get apiUrl {
    switch (this) {
      case AppEnvironment.development:
        return 'http://localhost:3001';
      case AppEnvironment.staging:
        return 'https://api-staging.example.com';
      case AppEnvironment.production:
        return 'https://api.example.com';
    }
  }

  bool get isDevelopment => this == AppEnvironment.development;
  bool get isProduction => this == AppEnvironment.production;
}
