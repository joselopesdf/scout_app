import '../../../l10n/app_localizations.dart';
import '../domain/entities/player_position.dart';
import '../domain/entities/preferred_foot.dart';

String playerPositionText(AppLocalizations l10n, PlayerPosition position) {
  return switch (position) {
    PlayerPosition.goalkeeper => l10n.positionGoalkeeper,
    PlayerPosition.defender => l10n.positionDefender,
    PlayerPosition.midfielder => l10n.positionMidfielder,
    PlayerPosition.forward => l10n.positionForward,
  };
}

String preferredFootText(AppLocalizations l10n, PreferredFoot foot) {
  return switch (foot) {
    PreferredFoot.left => l10n.footLeft,
    PreferredFoot.right => l10n.footRight,
    PreferredFoot.both => l10n.footBoth,
  };
}
