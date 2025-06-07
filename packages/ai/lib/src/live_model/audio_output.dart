part of 'live_model.dart';

class AudioOutput {
  // final _logger = Logger('_AudioOutput');
  AudioSource? _audioSource;
  SoundHandle? _handle;

  Future<void> initialize({
    int sampleRate = 24000,
    Channels channels = Channels.mono,
  }) async {
    try {
      await SoLoud.instance.init(
        sampleRate: sampleRate,
        channels: channels,
        automaticCleanup: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> play() async {
    _audioSource = SoLoud.instance.setBufferStream(
      bufferingType: BufferingType.released,
      bufferingTimeNeeds: 0,
    );
    _handle = await SoLoud.instance.play(_audioSource!);
  }

  void addAudioData(Uint8List data) {
    if (_audioSource != null) {
      SoLoud.instance.addAudioDataStream(_audioSource!, data);
    }
  }

  Future<void> stop() async {
    if (_audioSource != null) {
      SoLoud.instance.setDataIsEnded(_audioSource!);
    }
    if (_handle != null) {
      await SoLoud.instance.stop(_handle!);
    }
  }

  void dispose() {
    SoLoud.instance.deinit();
  }
}
