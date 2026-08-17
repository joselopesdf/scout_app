import '../../domain/entities/player_profile.dart';

sealed class PlayerListState {
  const PlayerListState();
}

final class PlayerListInitial extends PlayerListState {
  const PlayerListInitial();
}

final class PlayerListLoading extends PlayerListState {
  const PlayerListLoading();
}

final class PlayerListReady extends PlayerListState {
  const PlayerListReady(this.players);

  final List<PlayerProfile> players;
}

final class PlayerListEmpty extends PlayerListState {
  const PlayerListEmpty();
}

final class PlayerListFailure extends PlayerListState {
  const PlayerListFailure();
}
