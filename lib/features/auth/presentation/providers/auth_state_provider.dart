import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ship_flutter_starter/core/di/service_locator.dart';
import 'package:ship_flutter_starter/core/services/storage_service.dart';
import 'auth_providers.dart';

part 'auth_state_provider.g.dart';

@riverpod
Future<bool> authState(Ref ref) async {
  final storageService = getIt<StorageService>();
  final token = storageService.getToken();
  
  if (token == null) {
    return false;
  }

  try {
    final useCase = ref.read(getCurrentUserUseCaseProvider);
    final user = await useCase();
    return user != null;
  } on DioException catch (e) {
    if (e.response?.statusCode == 401) {
      storageService.clearTokens();
      return false;
    }
    rethrow;
  } catch (_) {
    return false;
  }
}
