import '../models/users_list_response.dart';
import '../../domain/repositories/users_repository.dart';

abstract class UsersApiInterface {
  Future<UsersListResponseModel> getUsersList(UsersListParams params);
}
