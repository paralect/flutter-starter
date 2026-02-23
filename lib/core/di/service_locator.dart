import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ship_flutter_starter/features/auth/data/interfaces/auth_api_interface.dart';
import 'package:ship_flutter_starter/features/auth/data/resources/auth_api_impl.dart';
import 'package:ship_flutter_starter/features/auth/data/resources/auth_repository_impl.dart';
import 'package:ship_flutter_starter/features/auth/domain/repositories/auth_repository.dart';
import 'package:ship_flutter_starter/features/chat/data/interfaces/chat_api_interface.dart';
import 'package:ship_flutter_starter/features/chat/data/resources/chat_api_mock_impl.dart';
import 'package:ship_flutter_starter/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:ship_flutter_starter/features/chat/domain/repositories/chat_repository_interface.dart';
import 'package:ship_flutter_starter/core/services/api_service.dart';
import 'package:ship_flutter_starter/core/services/auth_service.dart';
import 'package:ship_flutter_starter/core/services/storage_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerSingleton<StorageService>(
    StorageService(sharedPreferences),
  );

  getIt.registerSingleton<ApiService>(
    ApiService(getIt<StorageService>()),
  );

  getIt.registerSingleton<AuthService>(
    AuthService(),
  );

  getIt.registerSingleton<AuthApiInterface>(
    AuthApiImpl(getIt<ApiService>()),
  );

  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      getIt<AuthApiInterface>(),
      getIt<StorageService>(),
      getIt<AuthService>(),
    ),
  );

  getIt.registerSingleton<ChatApiInterface>(
    ChatApiMockImpl(),
  );

  getIt.registerSingleton<ChatRepository>(
    ChatRepositoryImpl(getIt<ChatApiInterface>()),
  );
}
