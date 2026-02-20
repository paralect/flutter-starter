import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn;

  AuthService()
      : _googleSignIn = GoogleSignIn(
          scopes: ['email', 'profile'],
        );

  Future<GoogleSignInAuthentication?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      return await googleUser.authentication;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }
}
