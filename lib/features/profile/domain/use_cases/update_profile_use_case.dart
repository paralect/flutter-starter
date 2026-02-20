import 'package:ship_flutter_starter/features/auth/domain/entities/user_entity.dart';
import 'package:ship_flutter_starter/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<UserEntity> call(String firstName, String lastName, String? avatarUrl) {
    return _repository.updateProfile(firstName, lastName, avatarUrl);
  }
}
