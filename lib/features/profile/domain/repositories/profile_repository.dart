import 'package:ship_flutter_starter/features/auth/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getProfile();
  Future<UserEntity> updateProfile(String firstName, String lastName, String? avatarUrl);
}
