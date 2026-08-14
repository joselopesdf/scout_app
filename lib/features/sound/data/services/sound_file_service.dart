import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SoundFileService {
  static const String _soundsDirectoryName = 'sounds';

  Future<String> saveAudio({
    required String sourcePath,
    required String soundId,
  }) async {
    final sourceFile = File(sourcePath);

    if (!await sourceFile.exists()) {
      throw const FileSystemException(
        'O arquivo de áudio selecionado não existe.',
      );
    }

    final appDirectory =
    await getApplicationDocumentsDirectory();

    final soundsDirectory = Directory(
      '${appDirectory.path}'
          '${Platform.pathSeparator}'
          '$_soundsDirectoryName',
    );

    if (!await soundsDirectory.exists()) {
      await soundsDirectory.create(
        recursive: true,
      );
    }

    final extension = _getExtension(sourcePath);

    final destinationPath =
        '${soundsDirectory.path}'
        '${Platform.pathSeparator}'
        '$soundId$extension';

    final copiedFile = await sourceFile.copy(
      destinationPath,
    );

    return copiedFile.path;
  }

  Future<void> deleteAudio({
    required String path,
  }) async {
    final file = File(path);

    if (await file.exists()) {
      await file.delete();
    }
  }

  String _getExtension(String path) {
    final fileName =
        path.split(Platform.pathSeparator).last;

    final dotIndex = fileName.lastIndexOf('.');

    if (dotIndex == -1) {
      return '';
    }

    return fileName.substring(dotIndex).toLowerCase();
  }
}