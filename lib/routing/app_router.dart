import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ui/authentication/view_models/auth_session_state.dart';
import '../ui/authentication/view_models/auth_session_view_model.dart';
import '../ui/authentication/widgets/login_page.dart';
import '../ui/authentication/widgets/splash_page.dart';
import '../ui/home/widgets/home_page.dart';
import '../ui/onboarding/view_models/onboarding_state.dart';
import '../ui/onboarding/view_models/onboarding_view_model.dart';
import '../ui/onboarding/widgets/onboarding_page.dart';
import 'route_names.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ValueNotifier<int>(0);

  ref
    ..onDispose(refreshNotifier.dispose)
    ..listen(onboardingViewModelProvider, (_, _) {
      refreshNotifier.value++;
    })
    ..listen(authSessionViewModelProvider, (_, _) {
      refreshNotifier.value++;
    });

  return GoRouter(
    initialLocation: RouteNames.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authentication = ref.read(authSessionViewModelProvider);
      final location = state.matchedLocation;

      if (authentication is AuthSessionChecking) {
        return location == RouteNames.splash ? null : RouteNames.splash;
      }

      final onboarding = ref.read(onboardingViewModelProvider);
      if (onboarding is! OnboardingCompleted) {
        return location == RouteNames.onboarding ? null : RouteNames.onboarding;
      }

      final isAuthenticated = authentication is AuthSessionAuthenticated;
      if (!isAuthenticated) {
        return location == RouteNames.login ? null : RouteNames.login;
      }

      return location == RouteNames.home ? null : RouteNames.home;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
});
