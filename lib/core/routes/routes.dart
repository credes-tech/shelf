import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/authentication/AuthenticationRoutes.dart';
import 'package:my_shelf_project/modules/home/HomeRoutes.dart';
import 'package:my_shelf_project/modules/onboarding/OnboardingRoutes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/home/chats",
  routes: [
    ...OnboardingRoutes.routes,
    ...AuthenticationRoutes.routes,
    ...HomeRoutes.routes
  ],
);
