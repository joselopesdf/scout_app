import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/player_profile_repository.dart';
import '../providers/player_profile_providers.dart';
import 'player_profile_state.dart';

final playerProfileViewModelProvider =
    NotifierProvider<PlayerProfileViewModel, PlayerProfileState>(
      PlayerProfileViewModel.new,
    );

class PlayerProfileViewModel extends Notifier<PlayerProfileState> {
  late PlayerProfileRepository _repository;
  String? _loadedUserId;
  String? _loadingUserId;

  @override
  PlayerProfileState build() {
    _repository = ref.watch(playerProfileRepositoryProvider);
    return const PlayerProfileInitial();
  }

  Future<void> load(String userId, {bool force = false}) async {
    if (_loadingUserId == userId) return;
    if (!force && _loadedUserId == userId && state is PlayerProfileReady) {
      return;
    }

    _loadingUserId = userId;
    state = const PlayerProfileLoading();
    try {
      final profile = await _repository.getProfile(userId);
      _loadedUserId = userId;
      state = profile == null
          ? const PlayerProfileNotFound()
          : PlayerProfileReady(profile);
    } catch (error, stackTrace) {
      developer.log(
        'Não foi possível carregar o perfil do jogador.',
        name: 'PlayerProfile',
        error: error,
        stackTrace: stackTrace,
      );
      state = const PlayerProfileFailure();
    } finally {
      _loadingUserId = null;
    }
  }
}
