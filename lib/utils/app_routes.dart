import 'router_helpers.dart';
import '../screen/chat/chat.dart';
import '../screen/login/login.dart';
import '../screen/allChats/all_chats.dart';
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
    AppRouteConstants.chat: (context) {
      bool authCheck = RouteHelpers.checkAuth();
      return authCheck ? const ChatScreen() : const LoginScreen();
    },
  };
}
