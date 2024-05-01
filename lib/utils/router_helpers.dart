import 'package:websocket_chat_app/services/database_service.dart';

class RouteHelpers {
  static bool checkAuth() {
    final currentUser =
        DatabaseService.get(DatabaseService.userBox, "currentUser");
    if (currentUser != null) {
      return true;
    }
    return false;
  }
}
