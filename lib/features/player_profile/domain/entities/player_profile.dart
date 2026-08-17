import 'player_position.dart';
import 'preferred_foot.dart';

class PlayerProfile {
  const PlayerProfile({
    required this.userId,
    required this.fullName,
    required this.birthDate,
    required this.position,
    required this.preferredFoot,
    required this.currentClub,
    required this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  final String userId;
  final String fullName;
  final DateTime birthDate;
  final PlayerPosition position;
  final PreferredFoot preferredFoot;
  final String? currentClub;
  final String? bio;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerProfile &&
            userId == other.userId &&
            fullName == other.fullName &&
            birthDate == other.birthDate &&
            position == other.position &&
            preferredFoot == other.preferredFoot &&
            currentClub == other.currentClub &&
            bio == other.bio &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => Object.hash(
    userId,
    fullName,
    birthDate,
    position,
    preferredFoot,
    currentClub,
    bio,
    createdAt,
    updatedAt,
  );
}
