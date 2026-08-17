import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_app/features/player_profile/data/mappers/player_profile_mapper.dart';
import 'package:scout_app/features/player_profile/domain/entities/player_position.dart';
import 'package:scout_app/features/player_profile/domain/entities/preferred_foot.dart';

void main() {
  test('converte documento Firestore em PlayerProfile', () {
    final profile = PlayerProfileMapper.fromFirestore(
      documentId: 'player-1',
      data: {
        'userId': 'player-1',
        'fullName': '  Alex Silva  ',
        'birthDate': Timestamp.fromDate(DateTime(2000, 5, 10)),
        'position': 'midfielder',
        'preferredFoot': 'right',
        'currentClub': 'Scout FC',
        'bio': null,
        'createdAt': Timestamp.fromDate(DateTime(2026, 1, 1)),
        'updatedAt': Timestamp.fromDate(DateTime(2026, 1, 2)),
      },
    );

    expect(profile.userId, 'player-1');
    expect(profile.fullName, 'Alex Silva');
    expect(profile.position, PlayerPosition.midfielder);
    expect(profile.preferredFoot, PreferredFoot.right);
    expect(profile.bio, isNull);
  });

  test('rejeita userId diferente do id do documento', () {
    expect(
      () => PlayerProfileMapper.fromFirestore(
        documentId: 'player-1',
        data: const {'userId': 'outro'},
      ),
      throwsFormatException,
    );
  });
}
