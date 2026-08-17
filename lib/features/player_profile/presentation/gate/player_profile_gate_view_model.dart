import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/player_profile_repository.dart';
import '../providers/player_profile_providers.dart';
import 'player_profile_gate_state.dart';

final playerProfileGateViewModelProvider =
    NotifierProvider<PlayerProfileGateViewModel, PlayerProfileGateState>(
      PlayerProfileGateViewModel.new,
    );

class PlayerProfileGateViewModel extends Notifier<PlayerProfileGateState> {
  late PlayerProfileRepository _repository;
  String? _loadingUserId;

  @override
  PlayerProfileGateState build() {
    _repository = ref.watch(playerProfileRepositoryProvider);
    return const PlayerProfileGateInitial();
  }

  Future<void> load(String userId) async {
    if (_loadingUserId == userId) return;
    _loadingUserId = userId;
    state = const PlayerProfileGateLoading();
    try {
      final profile = await _repository.getProfile(userId);
      state = profile == null
          ? const PlayerProfileGateNeedsCreation()
          : PlayerProfileGateReady(profile);
    } catch (error, stackTrace) {
      developer.log(
        'Não foi possível verificar o perfil do jogador.',
        name: 'PlayerProfileGate',
        error: error,
        stackTrace: stackTrace,
      );
      state = const PlayerProfileGateFailure();
    } finally {
      _loadingUserId = null;
    }
  }
}
