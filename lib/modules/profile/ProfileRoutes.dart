import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/profile/ui/pages/ProfileScreen.dart';
import 'package:my_shelf_project/modules/profile/ui/pages/SettingsScreen.dart';
import 'package:my_shelf_project/modules/profile/ui/pages/SupportScreen.dart';
import 'package:my_shelf_project/modules/profile/ui/pages/UpdateScreen.dart';
import 'package:my_shelf_project/modules/profile/ui/pages/VersionScreen.dart';

class ProfileRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/home/profile',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: '/home/profile/settings',
      builder: (context, state) => SettingsScreen(),
    ),
    GoRoute(
      path: '/home/profile/settings/support',
      builder: (context, state) => SupportScreen(),
    ),
    GoRoute(
      path: '/home/profile/settings/version',
      builder: (context, state) => VersionScreen(),
    ),
    GoRoute(
      path: '/home/profile/settings/update',
      builder: (context, state) => UpdateScreen(),
    ),

  ];
}