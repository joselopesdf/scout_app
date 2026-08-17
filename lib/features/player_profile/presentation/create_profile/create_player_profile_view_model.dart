import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/player_position.dart';
import '../../domain/entities/player_profile.dart';
import '../../domain/entities/preferred_foot.dart';
import '../../domain/repositories/player_profile_repository.dart';
import '../providers/player_profile_providers.dart';
import 'create_player_profile_state.dart';

final createPlayerProfileViewModelProvider =
    NotifierProvider<CreatePlayerProfileViewModel, CreatePlayerProfileState>(
      CreatePlayerProfileViewModel.new,
    );

class CreatePlayerProfileViewModel extends Notifier<CreatePlayerProfileState> {
  late PlayerProfileRepository _repository;

  @override
  CreatePlayerProfileState build() {
    _repository = ref.watch(playerProfileRepositoryProvider);
    return const CreatePlayerProfileState();
  }

  void setInitialName(String? value) {
    if (state.fullName.isNotEmpty || value == null) return;
    updateFullName(value);
  }

  void updateFullName(String value) => _replace(fullName: value);

  void updateBirthDate(DateTime value) => _replace(birthDate: value);

  void updatePosition(PlayerPosition? value) => _replace(position: value);

  void updatePreferredFoot(PreferredFoot? value) =>
      _replace(preferredFoot: value);

  void updateCurrentClub(String value) => _replace(currentClub: value);

  void updateBio(String value) => _replace(bio: value);

  Future<void> save(String userId) async {
    if (state.isSaving) return;

    final validationError = _validate();
    if (validationError != null) {
      _replace(error: validationError);
      return;
    }

    final profile = PlayerProfile(
      userId: userId,
      fullName: state.fullName.trim(),
      birthDate: state.birthDate!,
      position: state.position!,
      preferredFoot: state.preferredFoot!,
      currentClub: _optionalText(state.currentClub),
      bio: _optionalText(state.bio),
      createdAt: null,
      updatedAt: null,
    );

    _replace(isSaving: true);
    try {
      final created = await _repository.createProfile(profile);
      _replace(createdProfile: created);
    } catch (error, stackTrace) {
      developer.log(
        'Não foi possível criar o perfil do jogador.',
        name: 'CreatePlayerProfile',
        error: error,
        stackTrace: stackTrace,
      );
      _replace(error: CreatePlayerProfileError.saveFailed);
    }
  }

  CreatePlayerProfileError? _validate() {
    if (state.fullName.trim().isEmpty) {
      return CreatePlayerProfileError.fullNameRequired;
    }
    final birthDate = state.birthDate;
    if (birthDate == null) return CreatePlayerProfileError.birthDateRequired;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(birthDate.year, birthDate.month, birthDate.day);
    if (selected.isAfter(today)) {
      return CreatePlayerProfileError.birthDateInFuture;
    }
    if (state.position == null) {
      return CreatePlayerProfileError.positionRequired;
    }
    if (state.preferredFoot == null) {
      return CreatePlayerProfileError.preferredFootRequired;
    }
    return null;
  }

  String? _optionalText(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  void _replace({
    String? fullName,
    DateTime? birthDate,
    PlayerPosition? position,
    PreferredFoot? preferredFoot,
    String? currentClub,
    String? bio,
    bool isSaving = false,
    CreatePlayerProfileError? error,
    PlayerProfile? createdProfile,
  }) {
    state = CreatePlayerProfileState(
      fullName: fullName ?? state.fullName,
      birthDate: birthDate ?? state.birthDate,
      position: position ?? state.position,
      preferredFoot: preferredFoot ?? state.preferredFoot,
      currentClub: currentClub ?? state.currentClub,
      bio: bio ?? state.bio,
      isSaving: isSaving,
      error: error,
      createdProfile: createdProfile,
    );
  }
}
