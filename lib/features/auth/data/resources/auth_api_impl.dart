import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/api_service.dart';
import '../interfaces/auth_api_interface.dart';
import '../models/sign_in_request.dart';
import '../models/sign_up_request.dart';
import '../models/user_model.dart';

class AuthApiImpl implements AuthApiInterface {
  final ApiService _apiService;

  AuthApiImpl(this._apiService);

  @override
  Future<Response> signIn(String email, String password) async {
    final request = SignInRequest(
      email: email,
      password: password,
    );
    return _apiService.post(
      ApiConstants.accountSignIn,
      data: request.toJson(),
    );
  }

  @override
  Future<Response> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    final request = SignUpRequest(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    return _apiService.post(
      ApiConstants.accountSignUp,
      data: request.toJson(),
    );
  }

  @override
  Future<Response> signInWithGoogle(String idToken) async {
    return _apiService.post(
      ApiConstants.accountGoogleMobile,
      data: {
        'idToken': idToken,
      },
    );
  }

  @override
  Future<void> signOut() async {
    await _apiService.post(ApiConstants.accountSignOut);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await _apiService.get(ApiConstants.account);
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}
