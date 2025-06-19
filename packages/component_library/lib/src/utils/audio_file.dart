import 'dart:typed_data';

abstract class AudioFile {
  Future<Uint8List> readBytes(String path);
}
