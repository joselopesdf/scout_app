import '../../domain/entities/player_position.dart';
import '../../domain/entities/player_profile.dart';
import '../../domain/entities/preferred_foot.dart';

enum CreatePlayerProfileError {
  fullNameRequired,
  birthDateRequired,
  birthDateInFuture,
  positionRequired,
  preferredFootRequired,
  saveFailed,
}

class CreatePlayerProfileState {
  const CreatePlayerProfileState({
    this.fullName = '',
    this.birthDate,
    this.position,
    this.preferredFoot,
    this.currentClub = '',
    this.bio = '',
    this.isSaving = false,
    this.error,
    this.createdProfile,
  });

  final String fullName;
  final DateTime? birthDate;
  final PlayerPosition? position;
  final PreferredFoot? preferredFoot;
  final String currentClub;
  final String bio;
  final bool isSaving;
  final CreatePlayerProfileError? error;
  final PlayerProfile? createdProfile;

  bool get isSuccess => createdProfile != null;
}
