import 'package:dio/dio.dart';
import 'package:ship_flutter_starter/features/auth/data/models/user_model.dart';

abstract class AuthApiInterface {
  Future<Response> signIn(String email, String password);
  Future<Response> signUp(String email, String password, String firstName, String lastName);
  Future<Response> signInWithGoogle(String idToken);
  Future<void> signOut();
  Future<UserModel> getCurrentUser();
}
