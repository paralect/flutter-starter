import 'package:ship_flutter_starter/features/users/domain/repositories/users_repository.dart';
import 'package:ship_flutter_starter/features/users/data/interfaces/users_api_interface.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersApiInterface _api;

  UsersRepositoryImpl(this._api);

  @override
  Future<UsersListResponse> getUsersList(UsersListParams params) async {
    final response = await _api.getUsersList(params);
    return response.toEntity();
  }
}
