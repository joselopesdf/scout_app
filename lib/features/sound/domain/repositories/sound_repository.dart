abstract interface class SoundRepository {
  Future<String> saveLocalAudio({
    required String sourcePath,
    required String soundId,
  });

  Future<void> deleteLocalAudio({required String path});
}
