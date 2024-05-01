import 'router_helpers.dart';
import '../screen/chats/chats.dart';
import '../screen/login/login.dart';
import '../utils/app_route_contants.dart';

class AppRoutes {
  static final routesMap = {
    AppRouteConstants.home: (context) {
      bool authCheck = RouteHelpers.checkAuth();
      return authCheck ? const ChatsScreen() : const LoginScreen();
    },
    AppRouteConstants.chatsScreen: (context) {
      bool authCheck = RouteHelpers.checkAuth();
      return authCheck ? const ChatsScreen() : const LoginScreen();
    },
  };
}
