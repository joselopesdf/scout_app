

enum SoundSource {
  localFile,
  url,
}

enum SoundIcon {
  laugh,
  football,
  horn,
  clown,
  fire,
}

class CreateSoundState {
  final String name;
  final SoundSource source;
  final String url;
  final String? selectedFilePath;
  final SoundIcon selectedIcon;

  const CreateSoundState({
    this.name = '',
    this.source = SoundSource.localFile,
    this.url = '',
    this.selectedFilePath,
    this.selectedIcon = SoundIcon.laugh,
  });

  bool get canSubmit {
    if (name.trim().isEmpty) {
      return false;
    }

    return switch (source) {
      SoundSource.localFile => selectedFilePath != null,
      SoundSource.url => url.trim().isNotEmpty,
    };
  }

  CreateSoundState copyWith({
    String? name,
    SoundSource? source,
    String? url,
    String? selectedFilePath,
    SoundIcon? selectedIcon,
  }) {
    return CreateSoundState(
      name: name ?? this.name,
      source: source ?? this.source,
      url: url ?? this.url,
      selectedFilePath:
      selectedFilePath ?? this.selectedFilePath,
      selectedIcon: selectedIcon ?? this.selectedIcon,
    );
  }
}