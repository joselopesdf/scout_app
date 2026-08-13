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
  String get onboardingDescription => 'Connect players, scouts and clubs on a modern platform.';

  @override
  String get startButton => 'Get started';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle => 'Access your account to continue.';

  @override
  String get loginWithGoogle => 'Sign in with Google';

  @override
  String get loginError => 'Unable to sign in. Check the configuration and try again.';

  @override
  String get accountTypeTitle => 'Choose your profile';

  @override
  String get accountTypeQuestion => 'How do you want to use Scout?';

  @override
  String get accountTypeSubtitle => 'Choose an option to continue.';

  @override
  String get player => 'Player';

  @override
  String get playerDescription => 'Create your profile and showcase your talent.';

  @override
  String get scout => 'Scout';

  @override
  String get scoutDescription => 'Discover and follow players.';

  @override
  String get continueButton => 'Continue';

  @override
  String get accountTypeSaveError => 'Unable to save the account type.';
}
