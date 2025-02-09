import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/authentication/ui/pages/LoginPage.dart';
import 'package:my_shelf_project/modules/authentication/ui/pages/RegisterPage.dart';

class AuthenticationRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage()
    ),
    GoRoute(
        path: '/register',
        builder: (context, state) => RegisterPage()
    ),
  ];
}
