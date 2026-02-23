import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ship_flutter_starter/core/di/service_locator.dart';
import 'package:ship_flutter_starter/features/auth/domain/repositories/auth_repository.dart';
import 'package:ship_flutter_starter/features/auth/domain/use_cases/get_current_user_use_case.dart';
import 'package:ship_flutter_starter/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:ship_flutter_starter/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:ship_flutter_starter/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:ship_flutter_starter/features/auth/domain/use_cases/sign_up_use_case.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return getIt<AuthRepository>();
}

@riverpod
SignInUseCase signInUseCase(Ref ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
GoogleSignInUseCase googleSignInUseCase(Ref ref) {
  return GoogleSignInUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
GetCurrentUserUseCase getCurrentUserUseCase(Ref ref) {
  return GetCurrentUserUseCase(ref.watch(authRepositoryProvider));
}
