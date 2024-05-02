import 'package:websocket_chat_app/routes/app_route_contants.dart';
import 'package:websocket_chat_app/services/database_service.dart';
import 'package:websocket_chat_app/utils/database_constants.dart';

class RouteHelpers {
  static bool checkAuth() {
    final currentUser = DatabaseService.get(
      DatabaseService.userBox,
      DatabaseConstants.currentUser,
    );
    if (currentUser != null && currentUser != "") {
      return true;
    }
    return false;
  }

  static String checkAuthPath() {
    final currentUser = DatabaseService.get(
      DatabaseService.userBox,
      DatabaseConstants.currentUser,
    );
    if (currentUser != null && currentUser != "") {
      return AppRouteConstants.chatsScreen;
    }
    return AppRouteConstants.home;
  }
}
