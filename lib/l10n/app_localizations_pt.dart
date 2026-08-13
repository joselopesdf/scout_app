// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Scout App';

  @override
  String get onboardingDescription => 'Liga jogadores, olheiros e clubes numa plataforma moderna.';

  @override
  String get startButton => 'Começar';

  @override
  String get loginTitle => 'Entrar';

  @override
  String get loginSubtitle => 'Acede à tua conta para continuar.';

  @override
  String get loginWithGoogle => 'Entrar com Google';

  @override
  String get loginError => 'Não foi possível iniciar sessão. Verifica a configuração e tenta novamente.';

  @override
  String get accountTypeTitle => 'Escolha o seu perfil';

  @override
  String get accountTypeQuestion => 'Como quer utilizar o Scout?';

  @override
  String get accountTypeSubtitle => 'Escolha uma opção para continuar.';

  @override
  String get player => 'Jogador';

  @override
  String get playerDescription => 'Crie o seu perfil e mostre o seu talento.';

  @override
  String get scout => 'Olheiro';

  @override
  String get scoutDescription => 'Descubra e acompanhe jogadores.';

  @override
  String get continueButton => 'Continuar';

  @override
  String get accountTypeSaveError => 'Não foi possível guardar o tipo da conta.';
}
