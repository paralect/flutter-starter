import 'package:ship_flutter_starter/features/users/domain/repositories/users_repository.dart';

class GetUsersListUseCase {
  final UsersRepository _repository;

  GetUsersListUseCase(this._repository);

  Future<UsersListResponse> call(UsersListParams params) {
    return _repository.getUsersList(params);
  }
}
