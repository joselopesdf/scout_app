import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_app/features/authentication/domain/entities/app_user.dart';
import 'package:scout_app/features/authentication/domain/repositories/account_repository.dart';
import 'package:scout_app/features/authentication/presentation/providers/authentication_providers.dart';
import 'package:scout_app/features/authentication/presentation/viewmodels/account_bootstrap_state.dart';
import 'package:scout_app/features/authentication/presentation/viewmodels/account_bootstrap_view_model.dart';

void main() {
  test(
    'carrega o mesmo utilizador apenas uma vez quando já está ready',
    () async {
      final repository = FakeAccountRepository();
      final container = ProviderContainer(
        overrides: [accountRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final viewModel = container.read(
        accountBootstrapViewModelProvider.notifier,
      );
      final user = AppUser.fromAuthentication(uid: 'user-1');

      await viewModel.loadOrCreateUser(user);
      await viewModel.loadOrCreateUser(user);

      expect(repository.calls, 1);
      expect(
        container.read(accountBootstrapViewModelProvider),
        isA<AccountBootstrapReady>(),
      );
    },
  );

  test('permite retry depois de uma falha', () async {
    final repository = FakeAccountRepository(failFirstCall: true);
    final container = ProviderContainer(
      overrides: [accountRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final viewModel = container.read(
      accountBootstrapViewModelProvider.notifier,
    );
    final user = AppUser.fromAuthentication(uid: 'user-1');

    await viewModel.loadOrCreateUser(user);
    expect(
      container.read(accountBootstrapViewModelProvider),
      isA<AccountBootstrapFailure>(),
    );

    await viewModel.retry(user);

    expect(repository.calls, 2);
    expect(
      container.read(accountBootstrapViewModelProvider),
      isA<AccountBootstrapReady>(),
    );
  });
}

class FakeAccountRepository implements AccountRepository {
  FakeAccountRepository({this.failFirstCall = false});

  final bool failFirstCall;
  int calls = 0;

  @override
  Future<AppUser> loadOrCreateUser(AppUser authenticatedUser) async {
    calls++;
    if (failFirstCall && calls == 1) {
      throw Exception('Firestore indisponível');
    }
    return authenticatedUser;
  }
}
