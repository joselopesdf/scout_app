import '../../domain/entities/player_profile.dart';
import '../../domain/repositories/player_profile_repository.dart';
import '../mappers/player_profile_mapper.dart';
import '../services/player_firestore_service.dart';

class PlayerProfileRepositoryImpl implements PlayerProfileRepository {
  PlayerProfileRepositoryImpl({required PlayerFirestoreService service})
    : _service = service;

  final PlayerFirestoreService _service;

  @override
  Future<PlayerProfile> createProfile(PlayerProfile profile) async {
    final existing = await _service.findByUserId(profile.userId);
    if (existing.exists) {
      throw StateError('O perfil do jogador já existe.');
    }

    await _service.create(
      userId: profile.userId,
      data: PlayerProfileMapper.toCreateMap(profile),
    );

    final created = await getProfile(profile.userId);
    if (created == null) {
      throw StateError('O perfil foi criado, mas não pôde ser carregado.');
    }
    return created;
  }

  @override
  Future<PlayerProfile?> getProfile(String userId) async {
    final document = await _service.findByUserId(userId);
    final data = document.data();
    if (!document.exists || data == null) return null;
    return PlayerProfileMapper.fromFirestore(
      documentId: document.id,
      data: data,
    );
  }

  @override
  Future<List<PlayerProfile>> listPlayers() async {
    final snapshot = await _service.list();
    return snapshot.docs
        .map(
          (document) => PlayerProfileMapper.fromFirestore(
            documentId: document.id,
            data: document.data(),
          ),
        )
        .toList(growable: false);
  }
}
