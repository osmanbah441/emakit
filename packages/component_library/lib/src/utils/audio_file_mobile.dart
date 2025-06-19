import 'dart:io';
import 'dart:typed_data';

import 'audio_file.dart';

class AudioFileImpl implements AudioFile {
  @override
  Future<Uint8List> readBytes(String path) async {
    try {
      final file = File(path);
      if (!await file.exists()) {
        throw ('Audio file not found at path: "$path"',);
      }
      return await file.readAsBytes();
    } catch (e) {
      throw ("Failed to read audio file from disk: $path' originalError: $e",);
    }
  }
}
