import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ship_flutter_starter/features/auth/domain/entities/user_entity.dart';
import 'auth_providers.dart';

part 'sign_up_provider.g.dart';

@riverpod
class SignUp extends _$SignUp {
  @override
  Future<UserEntity?> build() async => null;

  Future<void> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(signUpUseCaseProvider);
      return await useCase(email, password, firstName, lastName);
    });
  }
}
