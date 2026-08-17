import '../entities/player_profile.dart';

abstract interface class PlayerProfileRepository {
  Future<PlayerProfile> createProfile(PlayerProfile profile);

  Future<PlayerProfile?> getProfile(String userId);

  Future<List<PlayerProfile>> listPlayers();
}
