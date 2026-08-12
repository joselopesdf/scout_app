import '../../../core/storage/settings_local_service.dart';

class OnboardingService {
  OnboardingService(this._storage);

  static const _completedKey = 'onboarding_completed';

  final SettingsLocalService _storage;

  bool get isCompleted => _storage.readBool(_completedKey) ?? false;

  Future<void> markAsCompleted() {
    return _storage.writeBool(_completedKey, true);
  }
}
