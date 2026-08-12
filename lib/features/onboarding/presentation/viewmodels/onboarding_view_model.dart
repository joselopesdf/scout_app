import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/onboarding_repository.dart';
import '../providers/onboarding_providers.dart';
import 'onboarding_state.dart';

final onboardingViewModelProvider =
    NotifierProvider<OnboardingViewModel, OnboardingState>(
      OnboardingViewModel.new,
    );

class OnboardingViewModel extends Notifier<OnboardingState> {
  late OnboardingRepository _repository;

  @override
  OnboardingState build() {
    _repository = ref.watch(onboardingRepositoryProvider);
    try {
      return _repository.hasCompletedOnboarding()
          ? const OnboardingCompleted()
          : const OnboardingIncomplete();
    } catch (_) {
      return const OnboardingFailure('Não foi possível carregar o onboarding.');
    }
  }

  Future<void> complete() async {
    if (state is OnboardingCompleting || state is OnboardingCompleted) return;

    state = const OnboardingCompleting();
    try {
      await _repository.completeOnboarding();
      state = const OnboardingCompleted();
    } catch (_) {
      state = const OnboardingFailure(
        'Não foi possível guardar a conclusão. Tenta novamente.',
      );
    }
  }
}
