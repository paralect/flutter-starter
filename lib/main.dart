import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ship_flutter_starter/core/di/service_locator.dart';
import 'package:ship_flutter_starter/core/services/api_service.dart';
import 'package:ship_flutter_starter/core/theme/providers/theme_provider.dart';
import 'package:ship_flutter_starter/core/theme/tokens/color_tokens.dart';
import 'package:ship_flutter_starter/features/auth/presentation/providers/account_provider.dart';
import 'package:ship_flutter_starter/features/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final apiService = getIt<ApiService>();
      apiService.setOnUnauthorizedCallback(() {
        ref.invalidate(accountProvider);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final colors = ref.watch(appColorsProvider);

    return MaterialApp.router(
      title: 'Ship Flutter Starter',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: colors[AppColorTokens.primary.token]!,
        ),
      ),
    );
  }
}
