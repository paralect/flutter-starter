import '../../domain/repositories/users_repository.dart';
import '../interfaces/users_api_interface.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersApiInterface _api;

  UsersRepositoryImpl(this._api);

  @override
  Future<UsersListResponse> getUsersList(UsersListParams params) async {
    final response = await _api.getUsersList(params);
    return response.toEntity();
  }
}
