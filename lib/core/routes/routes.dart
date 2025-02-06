import 'package:go_router/go_router.dart';
import 'package:shelf/modules/authentication/AuthenticationRoutes.dart';
import 'package:shelf/modules/home/HomeRoutes.dart';
import 'package:shelf/modules/onboarding/OnboardingRoutes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/home/chats",
  routes: [
    ...OnboardingRoutes.routes,
    ...AuthenticationRoutes.routes,
    ...HomeRoutes.routes
  ],
);
