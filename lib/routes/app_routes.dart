import 'package:go_router/go_router.dart';
import 'package:websocket_chat_app/routes/router_helpers.dart';

import '/routes/app_route_contants.dart';
import '/screen/login/login.dart';
import '/screen/allChats/all_chats.dart';

class AppRoutes {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRouteConstants.home,
    routes: <RouteBase>[
      GoRoute(
        path: AppRouteConstants.home,
        builder: (context, state) {
          return const LoginScreen();
        },
        redirect: (context, state) {
          return RouteHelpers.checkAuthPath();
        },
      ),
      GoRoute(
        path: AppRouteConstants.chatsScreen,
        builder: (context, state) {
          return const ChatsScreen();
        },
        redirect: (context, state) {
          return RouteHelpers.checkAuthPath();
        },
      ),
      GoRoute(
        path: AppRouteConstants.chat,
        builder: (context, state) {
          return const ChatsScreen();
        },
        redirect: (context, state) {
          return RouteHelpers.checkAuthPath();
        },
      ),
    ],
  );
  static GoRouter get routes => _router;
}
