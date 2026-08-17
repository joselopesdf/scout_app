import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_app/features/player_profile/presentation/providers/player_profile_providers.dart';
import 'package:scout_app/features/player_profile/presentation/view_profile/player_profile_state.dart';
import 'package:scout_app/features/player_profile/presentation/view_profile/player_profile_view_model.dart';

import '../../../../helpers/fake_player_profile_repository.dart';
import '../../../../helpers/player_profile_fixture.dart';

void main() {
  test('carrega perfil existente', () async {
    final profile = playerProfileFixture();
    final container = ProviderContainer(
      overrides: [
        playerProfileRepositoryProvider.overrideWithValue(
          FakePlayerProfileRepository(profiles: {profile.userId: profile}),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(playerProfileViewModelProvider.notifier)
        .load(profile.userId);

    expect(
      container.read(playerProfileViewModelProvider),
      isA<PlayerProfileReady>(),
    );
  });

  test('expõe notFound quando perfil não existe', () async {
    final container = ProviderContainer(
      overrides: [
        playerProfileRepositoryProvider.overrideWithValue(
          FakePlayerProfileRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(playerProfileViewModelProvider.notifier)
        .load('missing');

    expect(
      container.read(playerProfileViewModelProvider),
      isA<PlayerProfileNotFound>(),
    );
  });
}
