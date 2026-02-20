import 'package:ship_flutter_starter/features/auth/domain/entities/user_entity.dart';
import 'package:ship_flutter_starter/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<UserEntity> call() {
    return _repository.getProfile();
  }
}
