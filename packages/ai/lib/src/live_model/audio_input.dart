part of 'live_model.dart';

class AudioInput {
  AudioInput() : _recorder = AudioRecorder();

  final AudioRecorder _recorder;

  Future<void> initialize() async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      throw Exception('Microphone permission not granted.');
    }
  }

  Future<Stream<Uint8List>> startRecordingStream({
    int sampleRate = 24000,
    int numChannels = 1,
  }) async {
    final recordConfig = RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: sampleRate,
      numChannels: numChannels,
      echoCancel: true,
      noiseSuppress: true,
    );
    return await _recorder.startStream(recordConfig);
  }

  Future<void> stopRecording() async {
    await _recorder.stop();
  }

  void dispose() {
    _recorder.dispose();
  }
}
