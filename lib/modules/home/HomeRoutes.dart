import 'package:go_router/go_router.dart';
import 'package:shelf/modules/home/ui/home_screen.dart';

class HomeRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen()
    ),
  ];
}
