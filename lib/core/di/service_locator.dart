import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/interfaces/auth_api_interface.dart';
import '../../features/auth/data/resources/auth_api_impl.dart';
import '../../features/auth/data/resources/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

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
}
