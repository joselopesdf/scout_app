import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/account_repository.dart';
import '../providers/authentication_providers.dart';
import 'account_bootstrap_state.dart';

final accountBootstrapViewModelProvider =
    NotifierProvider<AccountBootstrapViewModel, AccountBootstrapState>(
      AccountBootstrapViewModel.new,
    );

class AccountBootstrapViewModel extends Notifier<AccountBootstrapState> {
  late final AccountRepository _repository;
  String? _loadedUid;
  String? _loadingUid;
  int _requestVersion = 0;

  @override
  AccountBootstrapState build() {
    _repository = ref.watch(accountRepositoryProvider);
    return const AccountBootstrapInitial();
  }

  Future<void> loadOrCreateUser(AppUser authenticatedUser) async {
    final uid = authenticatedUser.uid;
    if (_loadingUid == uid ||
        (_loadedUid == uid && state is AccountBootstrapReady)) {
      return;
    }

    final requestVersion = ++_requestVersion;
    _loadingUid = uid;
    state = const AccountBootstrapLoading();

    try {
      final user = await _repository.loadOrCreateUser(authenticatedUser);
      if (requestVersion != _requestVersion) return;

      _loadedUid = uid;
      state = AccountBootstrapReady(user);
    } catch (error, stackTrace) {
      if (requestVersion != _requestVersion) return;
      developer.log(
        'Não foi possível carregar ou criar o utilizador.',
        name: 'AccountBootstrap',
        error: error,
        stackTrace: stackTrace,
      );
      state = const AccountBootstrapFailure(
        'Não foi possível carregar a tua conta.',
      );
    } finally {
      if (requestVersion == _requestVersion) {
        _loadingUid = null;
      }
    }
  }

  Future<void> retry(AppUser authenticatedUser) {
    _loadedUid = null;
    return loadOrCreateUser(authenticatedUser);
  }

  void reset() {
    _requestVersion++;
    _loadedUid = null;
    _loadingUid = null;
    state = const AccountBootstrapInitial();
  }
}
