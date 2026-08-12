import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/pages/account_bootstrap_page.dart';
import '../../features/authentication/presentation/pages/account_page.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/splash_page.dart';
import '../../features/authentication/presentation/viewmodels/auth_session_state.dart';
import '../../features/authentication/presentation/viewmodels/auth_session_view_model.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/viewmodels/onboarding_state.dart';
import '../../features/onboarding/presentation/viewmodels/onboarding_view_model.dart';
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

      return location == RouteNames.accountBootstrap
          ? null
          : RouteNames.accountBootstrap;
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
        path: RouteNames.accountBootstrap,
        builder: (context, state) => const AccountBootstrapPage(),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: RouteNames.accountType,
        builder: (context, state) {
          return const AccountTypePage();
        },
      ),
    ],
  );
});
