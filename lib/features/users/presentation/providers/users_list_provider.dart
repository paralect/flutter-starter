import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/users_repository.dart';
import 'users_providers.dart';

part 'users_list_provider.g.dart';

@riverpod
class UsersList extends _$UsersList {
  @override
  Future<UsersListResponse> build() async {
    final useCase = ref.read(getUsersListUseCaseProvider);
    return await useCase(UsersListParams(page: 1, perPage: 10));
  }

  Future<void> loadMore() async {
    final currentData = state.valueOrNull;
    if (currentData == null) return;

    final currentPage = _getCurrentPage();
    final nextPage = currentPage + 1;

    if (nextPage > currentData.pagesCount) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getUsersListUseCaseProvider);
      final params = UsersListParams(page: nextPage, perPage: 10);
      final newData = await useCase(params);
      return UsersListResponse(
        results: [...currentData.results, ...newData.results],
        count: newData.count,
        pagesCount: newData.pagesCount,
      );
    });
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getUsersListUseCaseProvider);
      return await useCase(UsersListParams(page: 1, perPage: 10));
    });
  }

  Future<void> search(String query) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getUsersListUseCaseProvider);
      return await useCase(
        UsersListParams(page: 1, perPage: 10, searchValue: query),
      );
    });
  }

  int _getCurrentPage() {
    final currentData = state.valueOrNull;
    if (currentData == null) return 1;
    return (currentData.results.length / 10).ceil();
  }
}
