import '../../domain/repositories/sound_repository.dart';
import '../services/sound_file_service.dart';

class SoundRepositoryImpl implements SoundRepository {
  final SoundFileService _fileService;

  SoundRepositoryImpl({required SoundFileService fileService})
    : _fileService = fileService;

  @override
  Future<String> saveLocalAudio({
    required String sourcePath,
    required String soundId,
  }) async {
    return _fileService.saveAudio(sourcePath: sourcePath, soundId: soundId);
  }

  @override
  Future<void> deleteLocalAudio({required String path}) async {
    await _fileService.deleteAudio(path: path);
  }
}
