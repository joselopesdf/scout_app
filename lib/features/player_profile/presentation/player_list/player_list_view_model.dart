import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/player_profile_repository.dart';
import '../providers/player_profile_providers.dart';
import 'player_list_state.dart';

final playerListViewModelProvider =
    NotifierProvider<PlayerListViewModel, PlayerListState>(
      PlayerListViewModel.new,
    );

class PlayerListViewModel extends Notifier<PlayerListState> {
  late PlayerProfileRepository _repository;
  bool _isLoading = false;

  @override
  PlayerListState build() {
    _repository = ref.watch(playerProfileRepositoryProvider);
    return const PlayerListInitial();
  }

  Future<void> load() async {
    if (_isLoading) return;
    _isLoading = true;
    state = const PlayerListLoading();
    try {
      final players = await _repository.listPlayers();
      state = players.isEmpty
          ? const PlayerListEmpty()
          : PlayerListReady(players);
    } catch (error, stackTrace) {
      developer.log(
        'Não foi possível listar os jogadores.',
        name: 'PlayerList',
        error: error,
        stackTrace: stackTrace,
      );
      state = const PlayerListFailure();
    } finally {
      _isLoading = false;
    }
  }
}
