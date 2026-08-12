import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/account_type.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/account_repository.dart';
import '../account_type/account_type_state.dart';
import '../providers/authentication_providers.dart';


final accountTypeViewModelProvider =
NotifierProvider<AccountTypeViewModel, AccountTypeState>(
  AccountTypeViewModel.new,
);

class AccountTypeViewModel extends Notifier<AccountTypeState> {
  late AccountRepository _repository;

  @override
  AccountTypeState build() {
    _repository = ref.watch(accountRepositoryProvider);

    return const AccountTypeState();
  }

  void selectType(AccountType type) {
    if (state.isSaving) return;

    state = AccountTypeState(
      selectedType: type,
    );
  }

  Future<void> saveAccountType(AppUser user) async {
    final selectedType = state.selectedType;

    if (selectedType == null) return;

    if (state.isSaving) return;

    state = AccountTypeState(
      selectedType: selectedType,
      isSaving: true,
    );

    try {
      await _repository.updateAccountType(
        user: user,
        accountType: selectedType,
      );

      state = AccountTypeState(
        selectedType: selectedType,
        isSuccess: true,
      );
    } catch (_) {
      state = AccountTypeState(
        selectedType: selectedType,
        errorMessage: 'Não foi possível guardar o tipo da conta.',
      );
    }
  }
}