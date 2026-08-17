import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_app/features/player_profile/domain/entities/player_position.dart';
import 'package:scout_app/features/player_profile/domain/entities/preferred_foot.dart';
import 'package:scout_app/features/player_profile/presentation/create_profile/create_player_profile_state.dart';
import 'package:scout_app/features/player_profile/presentation/create_profile/create_player_profile_view_model.dart';
import 'package:scout_app/features/player_profile/presentation/providers/player_profile_providers.dart';

import '../../../../helpers/fake_player_profile_repository.dart';

void main() {
  test('cria perfil válido com sucesso', () async {
    final repository = FakePlayerProfileRepository();
    final container = ProviderContainer(
      overrides: [
        playerProfileRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    final viewModel = container.read(
      createPlayerProfileViewModelProvider.notifier,
    );

    viewModel
      ..updateFullName('  Alex Silva  ')
      ..updateBirthDate(DateTime(2000, 5, 10))
      ..updatePosition(PlayerPosition.midfielder)
      ..updatePreferredFoot(PreferredFoot.right);

    await viewModel.save('player-1');

    final state = container.read(createPlayerProfileViewModelProvider);
    expect(state.isSuccess, isTrue);
    expect(state.createdProfile?.fullName, 'Alex Silva');
    expect(repository.createCalls, 1);
  });

  test('não salva nome vazio', () async {
    final repository = FakePlayerProfileRepository();
    final container = ProviderContainer(
      overrides: [
        playerProfileRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(createPlayerProfileViewModelProvider.notifier)
        .save('player-1');

    final state = container.read(createPlayerProfileViewModelProvider);
    expect(state.error, CreatePlayerProfileError.fullNameRequired);
    expect(repository.createCalls, 0);
  });

  test('preserva formulário quando repository falha', () async {
    final repository = FakePlayerProfileRepository(
      createError: Exception('offline'),
    );
    final container = ProviderContainer(
      overrides: [
        playerProfileRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    final viewModel = container.read(
      createPlayerProfileViewModelProvider.notifier,
    );
    viewModel
      ..updateFullName('Alex Silva')
      ..updateBirthDate(DateTime(2000, 5, 10))
      ..updatePosition(PlayerPosition.forward)
      ..updatePreferredFoot(PreferredFoot.left);

    await viewModel.save('player-1');

    final state = container.read(createPlayerProfileViewModelProvider);
    expect(state.error, CreatePlayerProfileError.saveFailed);
    expect(state.fullName, 'Alex Silva');
    expect(state.isSaving, isFalse);
  });

  test('ignora double submit enquanto está salvando', () async {
    final completer = Completer<void>();
    final repository = FakePlayerProfileRepository(
      onCreate: (profile) async {
        await completer.future;
        return profile;
      },
    );
    final container = ProviderContainer(
      overrides: [
        playerProfileRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    final viewModel = container.read(
      createPlayerProfileViewModelProvider.notifier,
    );
    viewModel
      ..updateFullName('Alex Silva')
      ..updateBirthDate(DateTime(2000, 5, 10))
      ..updatePosition(PlayerPosition.forward)
      ..updatePreferredFoot(PreferredFoot.left);

    final firstSave = viewModel.save('player-1');
    final secondSave = viewModel.save('player-1');

    expect(repository.createCalls, 1);
    completer.complete();
    await Future.wait([firstSave, secondSave]);
  });
}
