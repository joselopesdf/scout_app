import 'onboarding_service.dart';

abstract interface class OnboardingRepository {
  bool hasCompletedOnboarding();

  Future<void> completeOnboarding();
}

class LocalOnboardingRepository implements OnboardingRepository {
  LocalOnboardingRepository(this._service);

  final OnboardingService _service;

  @override
  bool hasCompletedOnboarding() => _service.isCompleted;

  @override
  Future<void> completeOnboarding() => _service.markAsCompleted();
}
