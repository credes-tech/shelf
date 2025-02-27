import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/profile/ui/pages/ProfileScreen.dart';

class ProfileRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/home/profile',
      builder: (context, state) => ProfileScreen(),
    ),
  ];
}