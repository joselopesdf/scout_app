import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/pages/account_bootstrap_page.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/splash_page.dart';
import '../../features/authentication/presentation/viewmodels/auth_session_state.dart';
import '../../features/authentication/presentation/viewmodels/auth_session_view_model.dart';
import '../../features/authentication/presentation/viewmodels/account_bootstrap_state.dart';
import '../../features/authentication/presentation/viewmodels/account_bootstrap_view_model.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/viewmodels/onboarding_state.dart';
import '../../features/onboarding/presentation/viewmodels/onboarding_view_model.dart';
import '../../features/player_profile/presentation/player_list/scout_player_list_page.dart';
import '../../features/player_profile/presentation/view_profile/player_profile_page.dart';
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
    })
    ..listen(accountBootstrapViewModelProvider, (_, _) {
      refreshNotifier.value++;
    });

  return GoRouter(
    initialLocation: RouteNames.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authentication = ref.read(authSessionViewModelProvider);

      final onboarding = ref.read(onboardingViewModelProvider);

      final location = state.matchedLocation;

      // 1. Ainda verificando autenticação.
      if (authentication is AuthSessionChecking) {
        return location == RouteNames.splash ? null : RouteNames.splash;
      }

      // 2. Onboarding ainda não concluído.
      if (onboarding is! OnboardingCompleted) {
        return location == RouteNames.onboarding ? null : RouteNames.onboarding;
      }

      final isAuthenticated = authentication is AuthSessionAuthenticated;

      // 3. Não autenticado -> Login.
      if (!isAuthenticated) {
        return location == RouteNames.login ? null : RouteNames.login;
      }

      // 4. Usuário autenticado tentando acessar
      // páginas que já não fazem sentido.
      final isPublicRoute =
          location == RouteNames.splash ||
          location == RouteNames.onboarding ||
          location == RouteNames.login;

      if (isPublicRoute) {
        return RouteNames.accountBootstrap;
      }

      final account = ref.read(accountBootstrapViewModelProvider);
      if (account is! AccountBootstrapReady) {
        return location == RouteNames.accountBootstrap
            ? null
            : RouteNames.accountBootstrap;
      }

      final user = account.user;
      if (location == RouteNames.players && !user.isScout) {
        return RouteNames.accountBootstrap;
      }

      if (location.startsWith('/players/') &&
          user.isPlayer &&
          location != RouteNames.playerProfilePath(user.uid)) {
        return RouteNames.accountBootstrap;
      }

      // 5. Restante das páginas privadas são permitidas.
      return null;
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
        path: RouteNames.players,
        builder: (context, state) => const ScoutPlayerListPage(),
      ),
      GoRoute(
        path: RouteNames.playerProfile,
        builder: (context, state) =>
            PlayerProfilePage(userId: state.pathParameters['userId']!),
      ),
    ],
  );
});
