import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_app/features/player_profile/presentation/create_profile/create_player_profile_page.dart';
import 'package:scout_app/features/player_profile/presentation/providers/player_profile_providers.dart';
import 'package:scout_app/l10n/app_localizations.dart';

import '../../../../helpers/fake_player_profile_repository.dart';

void main() {
  testWidgets('mostra os campos essenciais do formulário', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          playerProfileRepositoryProvider.overrideWithValue(
            FakePlayerProfileRepository(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: CreatePlayerProfilePage(userId: 'player-1', onCompleted: () {}),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('Select date of birth'), findsOneWidget);
    expect(find.text('Position'), findsOneWidget);
    expect(find.text('Preferred foot'), findsOneWidget);
    expect(find.text('Save profile'), findsOneWidget);
  });
}
