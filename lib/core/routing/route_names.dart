abstract final class RouteNames {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const accountBootstrap = '/account-bootstrap';
  static const home = '/home';
  static const players = '/players';
  static const playerProfile = '/players/:userId';

  static String playerProfilePath(String userId) => '/players/$userId';
}
