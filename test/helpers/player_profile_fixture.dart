import 'package:scout_app/features/player_profile/domain/entities/player_position.dart';
import 'package:scout_app/features/player_profile/domain/entities/player_profile.dart';
import 'package:scout_app/features/player_profile/domain/entities/preferred_foot.dart';

PlayerProfile playerProfileFixture({
  String userId = 'player-1',
  String fullName = 'Alex Silva',
}) {
  return PlayerProfile(
    userId: userId,
    fullName: fullName,
    birthDate: DateTime(2000, 5, 10),
    position: PlayerPosition.midfielder,
    preferredFoot: PreferredFoot.right,
    currentClub: 'Scout FC',
    bio: 'Jogador de teste',
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );
}
