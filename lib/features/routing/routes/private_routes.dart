import 'package:go_router/go_router.dart';
import '../../users/presentation/screens/users_list_screen.dart';
import '../../profile/presentation/screens/profile_screen.dart';
import '../enums/app_routes_enum.dart';

RouteBase privateRoutes = GoRoute(
  path: PrivateRoute.home.path,
  name: PrivateRoute.home.path,
  builder: (context, state) => const UsersListScreen(),
  routes: [
    GoRoute(
      path: PrivateRoute.profile.path.replaceFirst('/', ''),
      name: PrivateRoute.profile.path,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
