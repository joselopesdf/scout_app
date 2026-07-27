import '../../../domain/models/app_user.dart';

sealed class AuthSessionState {
  const AuthSessionState();
}

final class AuthSessionChecking extends AuthSessionState {
  const AuthSessionChecking();
}

final class AuthSessionAuthenticated extends AuthSessionState {
  const AuthSessionAuthenticated(this.user);

  final AppUser user;
}

final class AuthSessionUnauthenticated extends AuthSessionState {
  const AuthSessionUnauthenticated();
}

final class AuthSessionFailure extends AuthSessionState {
  const AuthSessionFailure(this.message);

  final String message;
}
