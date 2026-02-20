import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ship_flutter_starter/features/auth/domain/entities/user_entity.dart';
import 'package:ship_flutter_starter/features/profile/presentation/providers/profile_providers.dart';

part 'profile_provider.g.dart';

@riverpod
class Profile extends _$Profile {
  @override
  Future<UserEntity?> build() async {
    final useCase = ref.read(getProfileUseCaseProvider);
    try {
      return await useCase();
    } catch (e) {
      return null;
    }
  }

  Future<void> loadProfile() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getProfileUseCaseProvider);
      return await useCase();
    });
  }

  Future<void> updateProfile(
    String firstName,
    String lastName,
    String? avatarUrl,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(updateProfileUseCaseProvider);
      return await useCase(firstName, lastName, avatarUrl);
    });
  }
}
