

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/providers.dart';
import '../../../data/repositories/account_repository.dart';
import '../../../domain/models/app_user.dart';
import 'account_bootstrap_state.dart';

final accountBootstrapViewModelProvider =
NotifierProvider<
    AccountBootstrapViewModel,
    AccountBootstrapState
>(
  AccountBootstrapViewModel.new,
);

class AccountBootstrapViewModel
    extends Notifier<AccountBootstrapState> {
  late final AccountRepository _repository;

  @override
  AccountBootstrapState build() {
    _repository = ref.watch(accountRepositoryProvider);

    return const AccountBootstrapInitial();
  }

  Future<void> loadOrCreateUser(
      AppUser authenticatedUser,
      ) async {
    if (state is AccountBootstrapLoading) {
      return;
    }

    state = const AccountBootstrapLoading();

    try {
      final user = await _repository.loadOrCreateUser(
        authenticatedUser,
      );

      state = AccountBootstrapReady(user);
    } catch (_) {
      state = const AccountBootstrapFailure(
        'Não foi possível carregar a tua conta.',
      );
    }
  }

  Future<void> retry(
      AppUser authenticatedUser,
      ) {
    return loadOrCreateUser(authenticatedUser);
  }

  void reset() {
    state = const AccountBootstrapInitial();
  }
}