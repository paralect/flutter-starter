import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ship_flutter_starter/features/auth/domain/entities/user_entity.dart';
import 'auth_providers.dart';

part 'google_sign_in_provider.g.dart';

@riverpod
class GoogleSignIn extends _$GoogleSignIn {
  @override
  Future<UserEntity?> build() async => null;

  Future<void> signIn() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(googleSignInUseCaseProvider);
      return await useCase();
    });
  }
}
