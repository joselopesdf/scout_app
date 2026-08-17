import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_app/features/authentication/presentation/providers/authentication_providers.dart';
import 'package:scout_app/features/player_profile/presentation/player_list/scout_player_list_page.dart';
import 'package:scout_app/features/player_profile/presentation/providers/player_profile_providers.dart';
import 'package:scout_app/l10n/app_localizations.dart';

import '../../../../helpers/fake_auth_repository.dart';
import '../../../../helpers/fake_player_profile_repository.dart';
import '../../../../helpers/player_profile_fixture.dart';

void main() {
  testWidgets('mostra jogadores disponíveis', (tester) async {
    final profile = playerProfileFixture();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          playerProfileRepositoryProvider.overrideWithValue(
            FakePlayerProfileRepository(profiles: {profile.userId: profile}),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ScoutPlayerListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Players'), findsOneWidget);
    expect(find.text('Alex Silva'), findsOneWidget);
    expect(find.textContaining('Midfielder'), findsOneWidget);
  });
}
