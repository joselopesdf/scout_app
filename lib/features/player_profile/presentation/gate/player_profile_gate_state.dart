import '../../domain/entities/player_profile.dart';

sealed class PlayerProfileGateState {
  const PlayerProfileGateState();
}

final class PlayerProfileGateInitial extends PlayerProfileGateState {
  const PlayerProfileGateInitial();
}

final class PlayerProfileGateLoading extends PlayerProfileGateState {
  const PlayerProfileGateLoading();
}

final class PlayerProfileGateNeedsCreation extends PlayerProfileGateState {
  const PlayerProfileGateNeedsCreation();
}

final class PlayerProfileGateReady extends PlayerProfileGateState {
  const PlayerProfileGateReady(this.profile);

  final PlayerProfile profile;
}

final class PlayerProfileGateFailure extends PlayerProfileGateState {
  const PlayerProfileGateFailure();
}
