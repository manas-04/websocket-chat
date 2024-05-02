import 'package:auto_route/auto_route.dart';

import '../routes/app_route_contants.dart';
import '../routes/auth_guard.dart';
import '../screen/allChats/all_chats.dart';
import '../screen/chat/chat.dart';
import '../screen/login/login.dart';

part 'auto_app_routes.gr.dart';

@AutoRouterConfig()
class AutoAppRoutes extends _$AutoAppRoutes {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: AppRouteConstants.home,
          page: LoginRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: AppRouteConstants.chatsScreen,
          page: ChatsRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: AppRouteConstants.chat,
          page: ChatRoute.page,
          guards: [
            AuthGuard(),
          ],
        ),
      ];
}
