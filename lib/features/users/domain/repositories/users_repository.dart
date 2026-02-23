import 'package:ship_flutter_starter/features/users/domain/entities/user_entity.dart';

class UsersListParams {
  final int page;
  final int perPage;
  final Map<String, String>? sort;
  final String? searchValue;

  UsersListParams({
    this.page = 1,
    this.perPage = 10,
    this.sort,
    this.searchValue,
  });
}

class UsersListResponse {
  final List<UserEntity> results;
  final int count;
  final int pagesCount;

  UsersListResponse({
    required this.results,
    required this.count,
    required this.pagesCount,
  });
}

abstract class UsersRepository {
  Future<UsersListResponse> getUsersList(UsersListParams params);
}
