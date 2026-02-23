import 'package:ship_flutter_starter/features/auth/domain/entities/user_entity.dart';
import 'package:ship_flutter_starter/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<UserEntity?> call() {
    return _repository.getCurrentUser();
  }
}
