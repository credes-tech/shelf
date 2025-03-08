import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/authentication/AuthenticationRoutes.dart';
import 'package:my_shelf_project/modules/editor/NotesRoutes.dart';
import 'package:my_shelf_project/modules/home/HomeRoutes.dart';
import 'package:my_shelf_project/modules/onboarding/OnboardingRoutes.dart';
import 'package:my_shelf_project/modules/profile/ProfileRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter appRouter = GoRouter(
    initialLocation: "/home/media",
    routes: [
      ...OnboardingRoutes.routes,
      ...AuthenticationRoutes.routes,
      ...HomeRoutes.routes,
      ...NotesRoutes.routes,
      ...ProfileRoutes.routes
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      bool isOnboarding = await _isFirstTimeLaunch();
      final String? currentPath = state.fullPath;
      log('Redirect: isOnboarding=$isOnboarding, path=$currentPath', name: 'ROUTE_LOG');
      if (!isOnboarding && (currentPath?.startsWith('/onboarding') ?? false)) {
        return '/home/media';
      }
      if (isOnboarding && !(currentPath?.startsWith('/onboarding') ?? false)) {
        return "/onboarding/page1";
      }
      return null;
    });

Future<bool> _isFirstTimeLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  bool isFirstTimeLaunch = prefs.getBool('isFirstTime') ?? true;
  return isFirstTimeLaunch;
}

Future<void> completeOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstTime', false);
}
