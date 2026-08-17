import '../../domain/entities/account_type.dart';

class AccountTypeState {
  final AccountType? selectedType;
  final bool isSaving;
  final String? errorMessage;
  final bool isSuccess;

  const AccountTypeState({
    this.selectedType,
    this.isSaving = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  bool get canContinue {
    return selectedType != null && !isSaving;
  }

  AccountTypeState copyWith({
    AccountType? selectedType,
    bool? isSaving,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AccountTypeState(
      selectedType: selectedType ?? this.selectedType,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
