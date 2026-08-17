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

    // Evita duas requests simultâneas para o mesmo utilizador.
    if (_loadingUid == uid) {
      return;
    }

    // Se já carregámos este utilizador e o estado continua Ready,
    // não precisamos consultar novamente o Firestore.
    if (_loadedUid == uid && state is AccountBootstrapReady) {
      return;
    }

    await _loadUser(authenticatedUser);
  }

  Future<void> refresh(AppUser authenticatedUser) async {
    // Aqui queremos explicitamente ignorar o cache.
    //
    // Exemplo:
    // accountType acabou de mudar no Firestore.
    _loadedUid = null;

    await _loadUser(authenticatedUser);
  }

  Future<void> retry(AppUser authenticatedUser) async {
    // Depois de uma falha queremos permitir uma nova tentativa.
    _loadedUid = null;

    await _loadUser(authenticatedUser);
  }

  Future<void> _loadUser(AppUser authenticatedUser) async {
    final uid = authenticatedUser.uid;

    // Mesmo refresh/retry não deve criar duas requests simultâneas.
    if (_loadingUid == uid) {
      return;
    }

    final requestVersion = ++_requestVersion;

    _loadingUid = uid;

    state = const AccountBootstrapLoading();

    try {
      final user = await _repository.loadOrCreateUser(authenticatedUser);

      // Se outra request mais recente começou,
      // ignoramos o resultado desta.
      if (requestVersion != _requestVersion) {
        return;
      }

      _loadedUid = uid;

      state = AccountBootstrapReady(user);
    } catch (error, stackTrace) {
      if (requestVersion != _requestVersion) {
        return;
      }

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

  void reset() {
    // Invalida qualquer request ainda em andamento.
    _requestVersion++;

    _loadedUid = null;
    _loadingUid = null;

    state = const AccountBootstrapInitial();
  }
}
