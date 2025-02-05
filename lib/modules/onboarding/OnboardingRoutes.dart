import 'package:go_router/go_router.dart';
import 'package:shelf/modules/onboarding/ui/onboarding_screen.dart';
import 'package:shelf/modules/onboarding/ui/pages/OnboardingPage1.dart';
import 'package:shelf/modules/onboarding/ui/pages/OnboardingPage2.dart';
import 'package:shelf/modules/onboarding/ui/pages/OnboardingPage3.dart';

class OnboardingRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/onboarding/page1',
      builder: (context, state) => OnboardingPage1(),
    ),
    GoRoute(
      path: '/onboarding/page2',
      builder: (context, state) => OnboardingPage2(),
    ),
    GoRoute(
      path: '/onboarding/page3',
      builder: (context, state) => OnboardingPage3(),
    ),
  ];
}