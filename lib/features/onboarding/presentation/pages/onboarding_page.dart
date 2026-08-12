import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/onboarding_state.dart';
import '../viewmodels/onboarding_view_model.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingViewModelProvider);
    final isCompleting = onboarding is OnboardingCompleting;

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
              const Spacer(),
              const Text(
                'Scout App',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Liga jogadores, olheiros e clubes numa plataforma moderna.',
                style: TextStyle(fontSize: 16, height: 1.4),
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
                      : const Text('Começar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
