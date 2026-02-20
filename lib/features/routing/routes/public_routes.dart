import 'package:go_router/go_router.dart';
import '../../auth/presentation/screens/forgot_password_screen.dart';
import '../../auth/presentation/screens/sign_in_screen.dart';
import '../../auth/presentation/screens/sign_up_screen.dart';
import '../enums/app_routes_enum.dart';

RouteBase publicRoutes = GoRoute(
  path: '/${PublicRoute.signin.path}',
  name: PublicRoute.signin.path,
  builder: (context, state) => const SignInScreen(),
  routes: [
    GoRoute(
      path: PublicRoute.signup.path,
      name: PublicRoute.signup.path,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: PublicRoute.forgotPassword.path,
      name: PublicRoute.forgotPassword.path,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
  ],
);
