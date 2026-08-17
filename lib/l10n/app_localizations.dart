import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Scout App'**
  String get appName;

  /// No description provided for @onboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Connect players, scouts and clubs on a modern platform.'**
  String get onboardingDescription;

  /// No description provided for @startButton.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get startButton;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Access your account to continue.'**
  String get loginSubtitle;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get loginWithGoogle;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Unable to sign in. Check the configuration and try again.'**
  String get loginError;

  /// No description provided for @accountTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your profile'**
  String get accountTypeTitle;

  /// No description provided for @accountTypeQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do you want to use Scout?'**
  String get accountTypeQuestion;

  /// No description provided for @accountTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose an option to continue.'**
  String get accountTypeSubtitle;

  /// No description provided for @player.
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// No description provided for @playerDescription.
  ///
  /// In en, this message translates to:
  /// **'Create your profile and showcase your talent.'**
  String get playerDescription;

  /// No description provided for @scout.
  ///
  /// In en, this message translates to:
  /// **'Scout'**
  String get scout;

  /// No description provided for @scoutDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover and follow players.'**
  String get scoutDescription;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @accountTypeSaveError.
  ///
  /// In en, this message translates to:
  /// **'Unable to save the account type.'**
  String get accountTypeSaveError;

  /// No description provided for @createPlayerProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Create player profile'**
  String get createPlayerProfileTitle;

  /// No description provided for @playerProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Player profile'**
  String get playerProfileTitle;

  /// No description provided for @playerFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get playerFullName;

  /// No description provided for @playerBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get playerBirthDate;

  /// No description provided for @playerBirthDateHint.
  ///
  /// In en, this message translates to:
  /// **'Select date of birth'**
  String get playerBirthDateHint;

  /// No description provided for @playerPosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get playerPosition;

  /// No description provided for @playerPreferredFoot.
  ///
  /// In en, this message translates to:
  /// **'Preferred foot'**
  String get playerPreferredFoot;

  /// No description provided for @playerCurrentClub.
  ///
  /// In en, this message translates to:
  /// **'Current club'**
  String get playerCurrentClub;

  /// No description provided for @playerCurrentClubOptional.
  ///
  /// In en, this message translates to:
  /// **'Current club (optional)'**
  String get playerCurrentClubOptional;

  /// No description provided for @playerBio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get playerBio;

  /// No description provided for @playerBioOptional.
  ///
  /// In en, this message translates to:
  /// **'Bio (optional)'**
  String get playerBioOptional;

  /// No description provided for @saveProfileButton.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get saveProfileButton;

  /// No description provided for @playerFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter the player\'s full name.'**
  String get playerFullNameRequired;

  /// No description provided for @playerBirthDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Select the date of birth.'**
  String get playerBirthDateRequired;

  /// No description provided for @playerBirthDateFuture.
  ///
  /// In en, this message translates to:
  /// **'The date of birth cannot be in the future.'**
  String get playerBirthDateFuture;

  /// No description provided for @playerPositionRequired.
  ///
  /// In en, this message translates to:
  /// **'Select a position.'**
  String get playerPositionRequired;

  /// No description provided for @playerPreferredFootRequired.
  ///
  /// In en, this message translates to:
  /// **'Select the preferred foot.'**
  String get playerPreferredFootRequired;

  /// No description provided for @playerProfileSaveError.
  ///
  /// In en, this message translates to:
  /// **'Unable to save the player profile. Try again.'**
  String get playerProfileSaveError;

  /// No description provided for @playerProfileLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the player profile.'**
  String get playerProfileLoadError;

  /// No description provided for @playerProfileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Player profile not found.'**
  String get playerProfileNotFound;

  /// No description provided for @positionGoalkeeper.
  ///
  /// In en, this message translates to:
  /// **'Goalkeeper'**
  String get positionGoalkeeper;

  /// No description provided for @positionDefender.
  ///
  /// In en, this message translates to:
  /// **'Defender'**
  String get positionDefender;

  /// No description provided for @positionMidfielder.
  ///
  /// In en, this message translates to:
  /// **'Midfielder'**
  String get positionMidfielder;

  /// No description provided for @positionForward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get positionForward;

  /// No description provided for @footLeft.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get footLeft;

  /// No description provided for @footRight.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get footRight;

  /// No description provided for @footBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get footBoth;

  /// No description provided for @playersTitle.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get playersTitle;

  /// No description provided for @playersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No player profiles are available yet.'**
  String get playersEmpty;

  /// No description provided for @playersLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the players.'**
  String get playersLoadError;

  /// No description provided for @tryAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgainButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
