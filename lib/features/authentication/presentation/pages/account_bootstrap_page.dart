import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scout_app/features/authentication/presentation/pages/account_page.dart';

import '../../../home/presentation/pages/home_page.dart';
import '../viewmodels/account_bootstrap_state.dart';
import '../viewmodels/account_bootstrap_view_model.dart';
import '../viewmodels/auth_session_state.dart';
import '../viewmodels/auth_session_view_model.dart';

class AccountBootstrapPage extends ConsumerStatefulWidget {
  const AccountBootstrapPage({super.key});

  @override
  ConsumerState<AccountBootstrapPage> createState() =>
      _AccountBootstrapPageState();
}

class _AccountBootstrapPageState extends ConsumerState<AccountBootstrapPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final authentication = ref.read(authSessionViewModelProvider);
      if (authentication is AuthSessionAuthenticated) {
        ref
            .read(accountBootstrapViewModelProvider.notifier)
            .loadOrCreateUser(authentication.user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bootstrap = ref.watch(accountBootstrapViewModelProvider);
    final authentication = ref.watch(authSessionViewModelProvider);

    return switch (bootstrap) {
      AccountBootstrapReady() => const AccountTypePage(),
      AccountBootstrapFailure(:final message) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: authentication is AuthSessionAuthenticated
                        ? () => ref
                              .read(accountBootstrapViewModelProvider.notifier)
                              .retry(authentication.user)
                        : null,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      _ => const Scaffold(body: Center(child: CircularProgressIndicator())),
    };
  }
}
