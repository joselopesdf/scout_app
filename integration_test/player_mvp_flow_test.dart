import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:scout_app/features/authentication/presentation/providers/authentication_providers.dart';
import 'package:scout_app/features/player_profile/domain/entities/player_position.dart';
import 'package:scout_app/features/player_profile/domain/entities/preferred_foot.dart';
import 'package:scout_app/features/player_profile/presentation/create_profile/create_player_profile_page.dart';
import 'package:scout_app/features/player_profile/presentation/create_profile/create_player_profile_view_model.dart';
import 'package:scout_app/features/player_profile/presentation/providers/player_profile_providers.dart';
import 'package:scout_app/features/player_profile/presentation/player_list/scout_player_list_page.dart';
import 'package:scout_app/features/player_profile/presentation/view_profile/player_profile_page.dart';
import 'package:scout_app/l10n/app_localizations.dart';

import '../test/helpers/fake_auth_repository.dart';
import '../test/helpers/fake_player_profile_repository.dart';
import '../test/helpers/player_profile_fixture.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Player cria perfil e visualiza o resultado', (tester) async {
    final repository = FakePlayerProfileRepository();
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        playerProfileRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: _PlayerFlowHarness(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final viewModel = container.read(
      createPlayerProfileViewModelProvider.notifier,
    );
    viewModel
      ..updateFullName('Alex Silva')
      ..updateBirthDate(DateTime(2000, 5, 10))
      ..updatePosition(PlayerPosition.midfielder)
      ..updatePreferredFoot(PreferredFoot.right);
    await tester.pump();

    await tester.tap(find.text('Save profile'));
    await tester.pumpAndSettle();

    expect(repository.profiles['player-1'], isNotNull);
    expect(find.text('Alex Silva'), findsOneWidget);
    expect(find.text('Midfielder'), findsOneWidget);
  });

  testWidgets('Scout lista e abre o perfil de um jogador', (tester) async {
    final profile = playerProfileFixture();
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        playerProfileRepositoryProvider.overrideWithValue(
          FakePlayerProfileRepository(profiles: {profile.userId: profile}),
        ),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/players',
      routes: [
        GoRoute(
          path: '/players',
          builder: (_, _) => const ScoutPlayerListPage(),
        ),
        GoRoute(
          path: '/players/:userId',
          builder: (_, state) =>
              PlayerProfilePage(userId: state.pathParameters['userId']!),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Alex Silva'), findsOneWidget);
    await tester.tap(find.text('Alex Silva'));
    await tester.pumpAndSettle();

    expect(find.text('Player profile'), findsOneWidget);
    expect(find.text('Midfielder'), findsOneWidget);
  });
}

class _PlayerFlowHarness extends StatefulWidget {
  const _PlayerFlowHarness();

  @override
  State<_PlayerFlowHarness> createState() => _PlayerFlowHarnessState();
}

class _PlayerFlowHarnessState extends State<_PlayerFlowHarness> {
  bool _created = false;

  @override
  Widget build(BuildContext context) {
    if (_created) return const PlayerProfilePage(userId: 'player-1');

    return CreatePlayerProfilePage(
      userId: 'player-1',
      onCompleted: () => setState(() => _created = true),
    );
  }
}
