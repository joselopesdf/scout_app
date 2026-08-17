import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../viewmodels/login_state.dart';
import '../viewmodels/login_view_model.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final loginState = ref.watch(loginViewModelProvider);
    final isLoading = loginState is LoginLoading;

    ref.listen(loginViewModelProvider, (previous, next) {
      if (next is LoginFailure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.loginError)));
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              Text(
                l10n.loginTitle,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(l10n.loginSubtitle, style: const TextStyle(fontSize: 16)),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: isLoading
                      ? null
                      : () => ref
                            .read(loginViewModelProvider.notifier)
                            .signInWithGoogle(),
                  icon: isLoading
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.login),
                  label: Text(l10n.loginWithGoogle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
