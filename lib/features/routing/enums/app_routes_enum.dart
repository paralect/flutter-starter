enum PublicRoute {
  signup('sign-up'),
  verification('verification'),
  signin('sign-in'),
  forgotPassword('forgot-password'),
  resetPassword('reset-password'),
  newPassword('new-password');

  const PublicRoute([this.path = '']);
  final String path;
}

enum PrivateRoute {
  home('/'),

  profile('/profile'),
  chats('/chats'),
  chat('/chats/:chatId');

  const PrivateRoute([this.path = '']);
  final String path;
}
