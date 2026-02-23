import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ship_flutter_starter/core/di/service_locator.dart';
import 'package:ship_flutter_starter/core/services/storage_service.dart';
import 'package:ship_flutter_starter/features/auth/domain/entities/user_entity.dart';
import 'auth_providers.dart';

part 'account_provider.g.dart';

@riverpod
Future<UserEntity?> account(Ref ref) async {
  final storageService = getIt<StorageService>();
  final token = storageService.getToken();

  if (token == null) {
    return null;
  }

  try {
    final useCase = ref.read(getCurrentUserUseCaseProvider);
    final user = await useCase();
    return user;
  } on DioException catch (e) {
    if (e.response?.statusCode == 401) {
      storageService.clearTokens();
      return null;
    }
    rethrow;
  } catch (_) {
    return null;
  }
}
