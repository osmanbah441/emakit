import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'audio_file.dart';

class AudioFileImpl implements AudioFile {
  @override
  Future<Uint8List> readBytes(String path) async {
    try {
      final response = await http.get(Uri.parse(path));
      return (response.statusCode == 200)
          ? response.bodyBytes
          : throw ('Failed to fetch blob: HTTP ${response.statusCode}',);
    } catch (e) {
      throw ('Failed to read recorded audio from blob URL: $e',);
    }
  }
}
