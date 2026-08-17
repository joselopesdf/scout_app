import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_app/features/authentication/presentation/providers/authentication_providers.dart';
import 'package:scout_app/features/player_profile/presentation/providers/player_profile_providers.dart';
import 'package:scout_app/features/player_profile/presentation/view_profile/player_profile_page.dart';
import 'package:scout_app/l10n/app_localizations.dart';

import '../../../../helpers/fake_auth_repository.dart';
import '../../../../helpers/fake_player_profile_repository.dart';
import '../../../../helpers/player_profile_fixture.dart';

void main() {
  testWidgets('mostra perfil carregado', (tester) async {
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
          home: PlayerProfilePage(userId: profile.userId),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Alex Silva'), findsOneWidget);
    expect(find.text('Midfielder'), findsOneWidget);
    expect(find.text('Scout FC'), findsOneWidget);
  });
}
