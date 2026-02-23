import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ship_flutter_starter/core/di/service_locator.dart';
import 'package:ship_flutter_starter/core/services/api_service.dart';
import 'package:ship_flutter_starter/core/theme/providers/theme_provider.dart';
import 'package:ship_flutter_starter/core/theme/themes/app_theme.dart';
import 'package:ship_flutter_starter/features/auth/presentation/providers/account_provider.dart';
import 'package:ship_flutter_starter/features/routing/app_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

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
    final themeMode = ref.watch(appThemeModeValueProvider);

    return shadcn.GestureDetector(
      onTap: () => shadcn.FocusManager.instance.primaryFocus?.unfocus(),
      behavior: shadcn.HitTestBehavior.translucent,
      child: shadcn.ShadcnApp.router(
        title: 'Ship Flutter Starter',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
      ),
    );
  }
}
