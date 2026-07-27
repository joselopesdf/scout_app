import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/providers.dart';
import '../../../data/repositories/auth_repository.dart';
import 'login_state.dart';

final loginViewModelProvider = NotifierProvider<LoginViewModel, LoginState>(
  LoginViewModel.new,
);

class LoginViewModel extends Notifier<LoginState> {
  late AuthRepository _repository;

  @override
  LoginState build() {
    _repository = ref.watch(authRepositoryProvider);
    return const LoginInitial();
  }

  Future<void> signInWithGoogle() async {
    if (state is LoginLoading) return;

    state = const LoginLoading();

    try {
      await _repository.signInWithGoogle();
      state = const LoginSuccess();
    } catch (_) {
      state = const LoginFailure(
        'Não foi possível iniciar sessão. '
        'Verifica a configuração e tenta novamente.',
      );
    }
  }
}
