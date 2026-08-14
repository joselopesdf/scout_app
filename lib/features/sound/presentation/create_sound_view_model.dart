

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_sound_state.dart';

final createSoundViewModelProvider =
NotifierProvider<CreateSoundViewModel, CreateSoundState>(
  CreateSoundViewModel.new,
);

class CreateSoundViewModel extends Notifier<CreateSoundState> {
  @override
  CreateSoundState build() {
    return const CreateSoundState();
  }

  void setName(String value) {
    state = state.copyWith(name: value);
  }

  void setSource(SoundSource source) {
    state = state.copyWith(source: source);
  }

  void setUrl(String value) {
    state = state.copyWith(url: value);
  }

  void setIcon(SoundIcon icon) {
    state = state.copyWith(selectedIcon: icon);
  }

  void setSelectedFile(String path) {
    state = state.copyWith(
      selectedFilePath: path,
    );
  }

  void clearSelectedFile() {
    state = CreateSoundState(
      name: state.name,
      source: state.source,
      url: state.url,
      selectedIcon: state.selectedIcon,
    );
  }

  void submit() {
    if (!state.canSubmit) {
      return;
    }

  }
}