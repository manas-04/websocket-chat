import 'package:auto_route/auto_route.dart';

import '../routes/auto_app_routes.dart';
import '../routes/router_helpers.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    bool authCheck = RouteHelpers.checkAuth();
    if (authCheck) {
      resolver.next(true);
    } else {
      router.popAndPush(const LoginRoute());
      resolver.next(false);
    }
  }
}
