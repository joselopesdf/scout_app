

import '../../../domain/models/app_user.dart';

sealed class AccountBootstrapState {
  const AccountBootstrapState();
}

class AccountBootstrapInitial extends AccountBootstrapState {
  const AccountBootstrapInitial();
}

class AccountBootstrapLoading extends AccountBootstrapState {
  const AccountBootstrapLoading();
}

class AccountBootstrapReady extends AccountBootstrapState {
  const AccountBootstrapReady(this.user);

  final AppUser user;
}

class AccountBootstrapFailure extends AccountBootstrapState {
  const AccountBootstrapFailure(this.message);

  final String message;
}