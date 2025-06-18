import 'dart:typed_data';

import 'package:record/record.dart';

import '../../models/models.dart';
import 'audio_file_web.dart'
    if (dart.library.io) 'audio_file_reader_mobile.dart';

final class AiRecorder {
  final _recorder = AudioRecorder();

  Stream<({double current, double max})> get getamplitudeStream => _recorder
      .onAmplitudeChanged(const Duration(milliseconds: 100))
      .map((amp) => (current: amp.current, max: amp.current));

  // [path]: The required output file path for all non-web platforms.
  // This parameter is ignored on the web. The final output path can be
  // retrieved when the stop() method is called.
  Future<void> startRecording({String path = ''}) async {
    if (!(await _recorder.hasPermission())) return;

    final recordConfig = RecordConfig(
      encoder: AudioEncoder.wav,
      sampleRate: 24000,
      numChannels: 1,
      echoCancel: true,
      noiseSuppress: true,
    );

    // TODO: generate mobile path
    await _recorder.start(recordConfig, path: path);
  }

  Future<void> cancelRecording() async => await _recorder.stop();

  Future<Uint8List> stopRecording() async {
    final path = await _recorder.stop();
    if (path == null) throw const AudioPathNotFoundException();
    return await AudioFileImpl().readBytes(path);
  }

  Future<void> dispose() async {
    if (await _recorder.isRecording()) await _recorder.stop();
    await _recorder.dispose();
  }
}
