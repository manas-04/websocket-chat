import '../routes/app_route_contants.dart';
import '../services/database_service.dart';
import '../utils/database_constants.dart';

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
