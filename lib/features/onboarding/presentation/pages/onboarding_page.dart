import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/locale_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../viewmodels/onboarding_state.dart';
import '../viewmodels/onboarding_view_model.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingViewModelProvider);
    final isCompleting = onboarding is OnboardingCompleting;

    final l10n = AppLocalizations.of(context)!;

    ref.listen(onboardingViewModelProvider, (previous, next) {
      if (next case OnboardingFailure(:final message)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.language),
                  onSelected: (value) {
                    final notifier = ref.read(appLanguageProvider.notifier);

                    switch (value) {
                      case 'pt':
                        notifier.setPortuguese();
                        break;
                      case 'en':
                        notifier.setEnglish();
                        break;
                      case 'system':
                        notifier.setSystem();
                        break;
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'system',
                      child: Text('Sistema'),
                    ),
                    PopupMenuItem(
                      value: 'pt',
                      child: Text('Português'),
                    ),
                    PopupMenuItem(
                      value: 'en',
                      child: Text('English'),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                l10n.appName,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.onboardingDescription,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: isCompleting
                      ? null
                      : () => ref
                            .read(onboardingViewModelProvider.notifier)
                            .complete(),
                  child: isCompleting
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      :   Text(l10n.startButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
