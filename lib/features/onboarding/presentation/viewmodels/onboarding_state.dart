sealed class OnboardingState {
  const OnboardingState();
}

final class OnboardingIncomplete extends OnboardingState {
  const OnboardingIncomplete();
}

final class OnboardingCompleting extends OnboardingState {
  const OnboardingCompleting();
}

final class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}

final class OnboardingFailure extends OnboardingState {
  const OnboardingFailure(this.message);

  final String message;
}
