import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ship_flutter_starter/core/di/service_locator.dart';
import 'package:ship_flutter_starter/core/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ship_flutter_starter/features/users/domain/repositories/users_repository.dart';
import 'package:ship_flutter_starter/features/users/domain/use_cases/get_users_list_use_case.dart';
import 'package:ship_flutter_starter/features/users/data/interfaces/users_api_interface.dart';
import 'package:ship_flutter_starter/features/users/data/resources/users_api_impl.dart';
import 'package:ship_flutter_starter/features/users/data/resources/users_repository_impl.dart';

part 'users_providers.g.dart';

@riverpod
UsersApiInterface usersApiInterface(Ref ref) {
  return UsersApiImpl(getIt<ApiService>());
}

@riverpod
UsersRepository usersRepository(Ref ref) {
  return UsersRepositoryImpl(ref.watch(usersApiInterfaceProvider));
}

@riverpod
GetUsersListUseCase getUsersListUseCase(Ref ref) {
  return GetUsersListUseCase(ref.watch(usersRepositoryProvider));
}
