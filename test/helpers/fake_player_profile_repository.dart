import 'package:scout_app/features/player_profile/domain/entities/player_profile.dart';
import 'package:scout_app/features/player_profile/domain/repositories/player_profile_repository.dart';

class FakePlayerProfileRepository implements PlayerProfileRepository {
  FakePlayerProfileRepository({
    Map<String, PlayerProfile>? profiles,
    this.createError,
    this.getError,
    this.listError,
    this.onCreate,
  }) : profiles = {...?profiles};

  final Map<String, PlayerProfile> profiles;
  final Object? createError;
  final Object? getError;
  final Object? listError;
  final Future<PlayerProfile> Function(PlayerProfile profile)? onCreate;
  int createCalls = 0;

  @override
  Future<PlayerProfile> createProfile(PlayerProfile profile) async {
    createCalls++;
    if (createError != null) throw createError!;
    if (onCreate != null) return onCreate!(profile);
    profiles[profile.userId] = profile;
    return profile;
  }

  @override
  Future<PlayerProfile?> getProfile(String userId) async {
    if (getError != null) throw getError!;
    return profiles[userId];
  }

  @override
  Future<List<PlayerProfile>> listPlayers() async {
    if (listError != null) throw listError!;
    final result = profiles.values.toList()
      ..sort((a, b) => a.fullName.compareTo(b.fullName));
    return result;
  }
}
