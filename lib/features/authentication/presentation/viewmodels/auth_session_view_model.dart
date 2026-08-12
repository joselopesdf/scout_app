import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/auth_repository.dart';
import '../providers/authentication_providers.dart';
import 'auth_session_state.dart';

final authSessionViewModelProvider =
    NotifierProvider<AuthSessionViewModel, AuthSessionState>(
      AuthSessionViewModel.new,
    );

class AuthSessionViewModel extends Notifier<AuthSessionState> {
  late AuthRepository _repository;
  StreamSubscription? _sessionSubscription;

  @override
  AuthSessionState build() {
    _repository = ref.watch(authRepositoryProvider);
    _sessionSubscription?.cancel();
    _sessionSubscription = _repository.watchCurrentUser().listen(
      (user) {
        state = user == null
            ? const AuthSessionUnauthenticated()
            : AuthSessionAuthenticated(user);
      },
      onError: (_, _) {
        state = const AuthSessionFailure(
          'Não foi possível verificar a sessão.',
        );
      },
    );
    ref.onDispose(() => unawaited(_sessionSubscription?.cancel()));

    return const AuthSessionChecking();
  }
}
