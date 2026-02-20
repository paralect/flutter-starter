import '../../../../core/services/auth_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../interfaces/auth_api_interface.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiInterface _api;
  final StorageService _storageService;
  final AuthService _authService;

  AuthRepositoryImpl(
    this._api,
    this._storageService,
    this._authService,
  );

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final response = await _api.signIn(email, password);
    final data = response.data as Map<String, dynamic>;
    final userModel = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    final token = _extractToken(data);
    if (token != null) {
      await _storageService.saveToken(token);
    }
    return userModel.toEntity();
  }

  @override
  Future<UserEntity> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    final response = await _api.signUp(email, password, firstName, lastName);
    final data = response.data as Map<String, dynamic>;
    final userModel = UserModel.fromJson(data);
    final token = _extractToken(data);
    if (token != null) {
      await _storageService.saveToken(token);
    }
    return userModel.toEntity();
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      final googleAuth = await _authService.signInWithGoogle();
      if (googleAuth == null) {
        throw Exception('Google sign in cancelled');
      }

      final response = await _api.signInWithGoogle(
        googleAuth.idToken ?? '',
        googleAuth.accessToken ?? '',
      );
      final data = response.data as Map<String, dynamic>;
      final userModel = UserModel.fromJson(data);
      final token = _extractToken(data);
      if (token != null) {
        await _storageService.saveToken(token);
      }

      return userModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _api.signOut();
    await _storageService.clearTokens();
    await _authService.signOutGoogle();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final userModel = await _api.getCurrentUser();
      return userModel.toEntity();
    } catch (e) {
      return null;
    }
  }

  String? _extractToken(Map<String, dynamic> response) {
    if (response.containsKey('accessToken')) {
      return response['accessToken'] as String?;
    }
    if (response.containsKey('token')) {
      return response['token'] as String?;
    }
    return null;
  }
}
