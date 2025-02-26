import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/authentication/AuthenticationRoutes.dart';
import 'package:my_shelf_project/modules/editor/NotesRoutes.dart';
import 'package:my_shelf_project/modules/file/FileRoutes.dart';
import 'package:my_shelf_project/modules/home/HomeRoutes.dart';
import 'package:my_shelf_project/modules/onboarding/OnboardingRoutes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/home/media",
  routes: [
    ...OnboardingRoutes.routes,
    ...AuthenticationRoutes.routes,
    ...HomeRoutes.routes,
    ...NotesRoutes.routes,
    ...FileRoutes.routes
  ],
);
