import 'package:ship_flutter_starter/features/auth/domain/entities/user_entity.dart';
import 'package:ship_flutter_starter/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<UserEntity> call(
    String email,
    String password,
    String firstName,
    String lastName,
  ) {
    return _repository.signUp(email, password, firstName, lastName);
  }
}
