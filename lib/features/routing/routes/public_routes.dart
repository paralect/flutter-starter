import 'package:go_router/go_router.dart';
import 'package:ship_flutter_starter/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:ship_flutter_starter/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ship_flutter_starter/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ship_flutter_starter/features/routing/enums/app_routes_enum.dart';

List<RouteBase> publicRoutes = [
  GoRoute(
    path: '/${PublicRoute.signin.path}',
    name: PublicRoute.signin.path,
    builder: (context, state) => const SignInScreen(),
    routes: [
      GoRoute(
        path: PublicRoute.forgotPassword.path,
        name: PublicRoute.forgotPassword.path,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
    ],
  ),
  GoRoute(
    path: '/${PublicRoute.signup.path}',
    name: PublicRoute.signup.path,
    builder: (context, state) => const SignUpScreen(),
  ),
];
