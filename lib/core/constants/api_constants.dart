class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:3001',
  );

  static const String accountSignIn = '/account/sign-in';
  static const String accountSignUp = '/account/sign-up';
  static const String accountSignOut = '/account/sign-out';
  static const String account = '/account';
  static const String accountGoogle = '/account/sign-in/google';
  static const String accountGoogleMobile = '/account/sign-in/google-mobile';
  static const String users = '/users';
}
