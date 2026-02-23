import 'package:go_router/go_router.dart';
import 'package:ship_flutter_starter/features/users/presentation/screens/users_list_screen.dart';
import 'package:ship_flutter_starter/features/profile/presentation/screens/profile_screen.dart';
import 'package:ship_flutter_starter/features/chat/presentation/screens/chats_list_screen.dart';
import 'package:ship_flutter_starter/features/chat/presentation/screens/chat_screen.dart';
import 'package:ship_flutter_starter/features/routing/enums/app_routes_enum.dart';

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
    GoRoute(
      path: PrivateRoute.chats.path.replaceFirst('/', ''),
      name: PrivateRoute.chats.path,
      builder: (context, state) => const ChatsListScreen(),
      routes: [
        GoRoute(
          path: ':chatId',
          name: 'chat',
          builder: (context, state) {
            final chatId = state.pathParameters['chatId']!;
            return ChatScreen(chatId: chatId);
          },
        ),
      ],
    ),
  ],
);
