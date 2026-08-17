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
  String get onboardingDescription =>
      'Liga jogadores, olheiros e clubes numa plataforma moderna.';

  @override
  String get startButton => 'Começar';

  @override
  String get loginTitle => 'Entrar';

  @override
  String get loginSubtitle => 'Acede à tua conta para continuar.';

  @override
  String get loginWithGoogle => 'Entrar com Google';

  @override
  String get loginError =>
      'Não foi possível iniciar sessão. Verifica a configuração e tenta novamente.';

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
  String get accountTypeSaveError =>
      'Não foi possível guardar o tipo da conta.';

  @override
  String get createPlayerProfileTitle => 'Criar perfil de jogador';

  @override
  String get playerProfileTitle => 'Perfil do jogador';

  @override
  String get playerFullName => 'Nome completo';

  @override
  String get playerBirthDate => 'Data de nascimento';

  @override
  String get playerBirthDateHint => 'Selecionar data de nascimento';

  @override
  String get playerPosition => 'Posição';

  @override
  String get playerPreferredFoot => 'Pé preferido';

  @override
  String get playerCurrentClub => 'Clube atual';

  @override
  String get playerCurrentClubOptional => 'Clube atual (opcional)';

  @override
  String get playerBio => 'Biografia';

  @override
  String get playerBioOptional => 'Biografia (opcional)';

  @override
  String get saveProfileButton => 'Guardar perfil';

  @override
  String get playerFullNameRequired => 'Introduz o nome completo do jogador.';

  @override
  String get playerBirthDateRequired => 'Seleciona a data de nascimento.';

  @override
  String get playerBirthDateFuture =>
      'A data de nascimento não pode estar no futuro.';

  @override
  String get playerPositionRequired => 'Seleciona uma posição.';

  @override
  String get playerPreferredFootRequired => 'Seleciona o pé preferido.';

  @override
  String get playerProfileSaveError =>
      'Não foi possível guardar o perfil. Tenta novamente.';

  @override
  String get playerProfileLoadError =>
      'Não foi possível carregar o perfil do jogador.';

  @override
  String get playerProfileNotFound => 'Perfil de jogador não encontrado.';

  @override
  String get positionGoalkeeper => 'Guarda-redes';

  @override
  String get positionDefender => 'Defesa';

  @override
  String get positionMidfielder => 'Médio';

  @override
  String get positionForward => 'Avançado';

  @override
  String get footLeft => 'Esquerdo';

  @override
  String get footRight => 'Direito';

  @override
  String get footBoth => 'Ambos';

  @override
  String get playersTitle => 'Jogadores';

  @override
  String get playersEmpty => 'Ainda não existem perfis de jogadores.';

  @override
  String get playersLoadError => 'Não foi possível carregar os jogadores.';

  @override
  String get tryAgainButton => 'Tentar novamente';
}
