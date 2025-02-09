import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/routes/routes_transitions.dart';
import 'package:my_shelf_project/modules/onboarding/ui/onboarding_screen.dart';
import 'package:my_shelf_project/modules/onboarding/ui/pages/OnboardingPage1.dart';
import 'package:my_shelf_project/modules/onboarding/ui/pages/OnboardingPage2.dart';
import 'package:my_shelf_project/modules/onboarding/ui/pages/OnboardingPage3.dart';

class OnboardingRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/onboarding/page1',
      pageBuilder: (context, state) => buildSlideTransition(state, OnboardingPage1()),
    ),
    GoRoute(
      path: '/onboarding/page2',
      pageBuilder: (context, state) => buildSlideTransition(state, OnboardingPage2()),
    ),
    GoRoute(
      path: '/onboarding/page3',
      builder: (context, state) => OnboardingPage3(),
      pageBuilder: (context, state) => buildSlideTransition(state, OnboardingPage3()),
    ),
  ];
}