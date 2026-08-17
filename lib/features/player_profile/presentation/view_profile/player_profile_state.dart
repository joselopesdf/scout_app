import '../../domain/entities/player_profile.dart';

sealed class PlayerProfileState {
  const PlayerProfileState();
}

final class PlayerProfileInitial extends PlayerProfileState {
  const PlayerProfileInitial();
}

final class PlayerProfileLoading extends PlayerProfileState {
  const PlayerProfileLoading();
}

final class PlayerProfileReady extends PlayerProfileState {
  const PlayerProfileReady(this.profile);

  final PlayerProfile profile;
}

final class PlayerProfileNotFound extends PlayerProfileState {
  const PlayerProfileNotFound();
}

final class PlayerProfileFailure extends PlayerProfileState {
  const PlayerProfileFailure();
}
