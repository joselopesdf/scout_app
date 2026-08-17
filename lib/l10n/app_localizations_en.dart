// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Scout App';

  @override
  String get onboardingDescription =>
      'Connect players, scouts and clubs on a modern platform.';

  @override
  String get startButton => 'Get started';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle => 'Access your account to continue.';

  @override
  String get loginWithGoogle => 'Sign in with Google';

  @override
  String get loginError =>
      'Unable to sign in. Check the configuration and try again.';

  @override
  String get accountTypeTitle => 'Choose your profile';

  @override
  String get accountTypeQuestion => 'How do you want to use Scout?';

  @override
  String get accountTypeSubtitle => 'Choose an option to continue.';

  @override
  String get player => 'Player';

  @override
  String get playerDescription =>
      'Create your profile and showcase your talent.';

  @override
  String get scout => 'Scout';

  @override
  String get scoutDescription => 'Discover and follow players.';

  @override
  String get continueButton => 'Continue';

  @override
  String get accountTypeSaveError => 'Unable to save the account type.';

  @override
  String get createPlayerProfileTitle => 'Create player profile';

  @override
  String get playerProfileTitle => 'Player profile';

  @override
  String get playerFullName => 'Full name';

  @override
  String get playerBirthDate => 'Date of birth';

  @override
  String get playerBirthDateHint => 'Select date of birth';

  @override
  String get playerPosition => 'Position';

  @override
  String get playerPreferredFoot => 'Preferred foot';

  @override
  String get playerCurrentClub => 'Current club';

  @override
  String get playerCurrentClubOptional => 'Current club (optional)';

  @override
  String get playerBio => 'Bio';

  @override
  String get playerBioOptional => 'Bio (optional)';

  @override
  String get saveProfileButton => 'Save profile';

  @override
  String get playerFullNameRequired => 'Enter the player\'s full name.';

  @override
  String get playerBirthDateRequired => 'Select the date of birth.';

  @override
  String get playerBirthDateFuture =>
      'The date of birth cannot be in the future.';

  @override
  String get playerPositionRequired => 'Select a position.';

  @override
  String get playerPreferredFootRequired => 'Select the preferred foot.';

  @override
  String get playerProfileSaveError =>
      'Unable to save the player profile. Try again.';

  @override
  String get playerProfileLoadError => 'Unable to load the player profile.';

  @override
  String get playerProfileNotFound => 'Player profile not found.';

  @override
  String get positionGoalkeeper => 'Goalkeeper';

  @override
  String get positionDefender => 'Defender';

  @override
  String get positionMidfielder => 'Midfielder';

  @override
  String get positionForward => 'Forward';

  @override
  String get footLeft => 'Left';

  @override
  String get footRight => 'Right';

  @override
  String get footBoth => 'Both';

  @override
  String get playersTitle => 'Players';

  @override
  String get playersEmpty => 'No player profiles are available yet.';

  @override
  String get playersLoadError => 'Unable to load the players.';

  @override
  String get tryAgainButton => 'Try again';
}
