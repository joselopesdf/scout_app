import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_app/features/player_profile/presentation/player_list/player_list_state.dart';
import 'package:scout_app/features/player_profile/presentation/player_list/player_list_view_model.dart';
import 'package:scout_app/features/player_profile/presentation/providers/player_profile_providers.dart';

import '../../../../helpers/fake_player_profile_repository.dart';
import '../../../../helpers/player_profile_fixture.dart';

void main() {
  test('lista jogadores ordenados pelo repository', () async {
    final first = playerProfileFixture(userId: '1', fullName: 'Ana');
    final second = playerProfileFixture(userId: '2', fullName: 'Bruno');
    final container = ProviderContainer(
      overrides: [
        playerProfileRepositoryProvider.overrideWithValue(
          FakePlayerProfileRepository(
            profiles: {first.userId: first, second.userId: second},
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(playerListViewModelProvider.notifier).load();

    final state = container.read(playerListViewModelProvider);
    expect(state, isA<PlayerListReady>());
    expect((state as PlayerListReady).players.length, 2);
  });

  test('expõe empty quando não há jogadores', () async {
    final container = ProviderContainer(
      overrides: [
        playerProfileRepositoryProvider.overrideWithValue(
          FakePlayerProfileRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(playerListViewModelProvider.notifier).load();

    expect(container.read(playerListViewModelProvider), isA<PlayerListEmpty>());
  });
}
