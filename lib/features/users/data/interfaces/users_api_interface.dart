import 'package:ship_flutter_starter/features/users/data/models/users_list_response.dart';
import 'package:ship_flutter_starter/features/users/domain/repositories/users_repository.dart';

abstract class UsersApiInterface {
  Future<UsersListResponseModel> getUsersList(UsersListParams params);
}
