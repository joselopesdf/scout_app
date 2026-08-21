import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/shared/widgets/scout_brand_mark.dart';
import '../../../../core/theme/presentation/scout_tokens.dart';
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(ScoutSpacing.lg),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - (ScoutSpacing.lg * 2),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: ScoutBrandMark(),
                        ),
                        const SizedBox(height: ScoutSpacing.xl),
                        Text(
                          l10n.appName,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                letterSpacing: 0.8,
                              ),
                        ),
                        const SizedBox(height: ScoutSpacing.sm),
                        Text(
                          l10n.loginTitle,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: ScoutSpacing.md),
                        Text(
                          l10n.loginSubtitle,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: ScoutSpacing.xxl),
                        FilledButton.icon(
                          onPressed: isLoading
                              ? null
                              : () => ref
                                    .read(loginViewModelProvider.notifier)
                                    .signInWithGoogle(),
                          icon: isLoading
                              ? const SizedBox.square(
                                  dimension: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.login_rounded),
                          label: Text(l10n.loginWithGoogle),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
