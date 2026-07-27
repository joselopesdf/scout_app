import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/providers.dart';
import '../../../data/repositories/auth_repository.dart';
import 'logout_state.dart';

final logoutViewModelProvider = NotifierProvider<LogoutViewModel, LogoutState>(
  LogoutViewModel.new,
);

class LogoutViewModel extends Notifier<LogoutState> {
  late AuthRepository _repository;

  @override
  LogoutState build() {
    _repository = ref.watch(authRepositoryProvider);
    return const LogoutInitial();
  }

  Future<void> signOut() async {
    if (state is LogoutLoading) return;

    state = const LogoutLoading();

    try {
      await _repository.signOut();
    } catch (_) {
      state = const LogoutFailure('Não foi possível terminar a sessão.');
    }
  }
}
