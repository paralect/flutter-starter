import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ship_flutter_starter/core/di/service_locator.dart';
import 'package:ship_flutter_starter/core/services/api_service.dart';
import 'package:ship_flutter_starter/features/profile/domain/repositories/profile_repository.dart';
import 'package:ship_flutter_starter/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:ship_flutter_starter/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:ship_flutter_starter/features/profile/data/interfaces/profile_api_interface.dart';
import 'package:ship_flutter_starter/features/profile/data/resources/profile_api_impl.dart';
import 'package:ship_flutter_starter/features/profile/data/resources/profile_repository_impl.dart';

part 'profile_providers.g.dart';

@riverpod
ProfileApiInterface profileApiInterface(Ref ref) {
  return ProfileApiImpl(getIt<ApiService>());
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepositoryImpl(ref.watch(profileApiInterfaceProvider));
}

@riverpod
GetProfileUseCase getProfileUseCase(Ref ref) {
  return GetProfileUseCase(ref.watch(profileRepositoryProvider));
}

@riverpod
UpdateProfileUseCase updateProfileUseCase(Ref ref) {
  return UpdateProfileUseCase(ref.watch(profileRepositoryProvider));
}
