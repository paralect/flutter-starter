import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ship_flutter_starter/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ship_flutter_starter/features/routing/enums/app_routes_enum.dart';
import 'package:ship_flutter_starter/features/routing/routes/public_routes.dart';
import 'package:ship_flutter_starter/features/routing/routes/private_routes.dart';

part 'app_router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggingIn =
          state.matchedLocation.startsWith('/${PublicRoute.signin.path}');
      final isSigningUp =
          state.matchedLocation.startsWith('/${PublicRoute.signup.path}');
      final isPublicRoute = isLoggingIn || isSigningUp;

      return authState.when(
        data: (isSignedIn) {
          if (!isSignedIn && !isPublicRoute) {
            return '/${PublicRoute.signin.path}';
          }
          if (isSignedIn && isPublicRoute) {
            return PrivateRoute.home.path;
          }
          return null;
        },
        loading: () => null,
        error: (err, stack) {
          return '/${PublicRoute.signin.path}';
        },
      );
    },
    routes: [
      publicRoutes,
      privateRoutes,
    ],
  );
}
