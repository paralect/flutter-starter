import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_providers.dart';

part 'sign_out_provider.g.dart';

@riverpod
class SignOut extends _$SignOut {
  @override
  Future<void> build() async {}

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(signOutUseCaseProvider);
      await useCase();
    });
  }
}
