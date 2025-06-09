import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';

import 'waveform_amplitude.dart';

class AudioService {
  // Renamed from _audioRecorder to _recordInstance for clarity, using the Record class.
  final _recordInstance = AudioRecorder();
  StreamSubscription<Uint8List>? _audioStreamSubscription;
  final List<int> _audioBytes = []; // Accumulate bytes from the stream

  bool _isRecording = false;
  bool get isRecording => _isRecording;

  AudioService();

  // Exposes a stream of custom WaveformAmplitude objects directly mapped from record's Amplitude.
  // NOW, we pass an interval to onAmplitudeChanged.
  Stream<WaveformAmplitude> get amplitudeStream {
    // Specify the interval for amplitude updates. 100ms is a good balance
    // for smooth animation without too many updates.
    return _recordInstance
        .onAmplitudeChanged(const Duration(milliseconds: 100))
        .map((amp) {
          // Map the record package's Amplitude object to our custom WaveformAmplitude.
          return WaveformAmplitude(current: amp.current, max: amp.max);
        });
  }

  Future<Stream<Uint8List>> startRecordingStream({
    int sampleRate = 24000,
    int numChannels = 1,
  }) async {
    final recordConfig = RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: 24000,
      numChannels: 1,
      echoCancel: true,
      noiseSuppress: true,
    );
    return await _recordInstance.startStream(recordConfig);
  }

  Future<void> startRecording() async {
    if (await _recordInstance.hasPermission()) {
      _audioBytes.clear();
      _isRecording = true;

      // Configure the encoder for raw PCM 16-bit bytes
      final recordConfig = RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: 24000,
        numChannels: 1,
        echoCancel: true,
        noiseSuppress: true,
      );

      // IMPORTANT: We must listen to the stream returned by startStream
      // to collect the audio chunks into _audioBytes.
      _audioStreamSubscription =
          (await _recordInstance.startStream(recordConfig)).listen(
            (audioChunk) {
              _audioBytes.addAll(audioChunk);
            },
            onError: (error) {
              print('Error during audio stream: $error');
              _isRecording = false;
              _audioBytes.clear(); // Discard bytes on error
            },
          );
      print('Recording started and streaming bytes.');
    } else {
      print('Microphone permission not granted.');
      _isRecording = false;
    }
  }

  Future<Uint8List?> stopAndGetRecordingBytes() async {
    if (_isRecording) {
      // It's important to cancel the subscription to stop receiving chunks
      // and ensure the stream resources are released.
      await _audioStreamSubscription?.cancel();
      _audioStreamSubscription = null;

      await _recordInstance.stop(); // Stop the underlying recorder hardware
      _isRecording = false;

      print('Recording stopped. Bytes collected: ${_audioBytes.length}');
      if (_audioBytes.isNotEmpty) {
        return Uint8List.fromList(_audioBytes);
      }
    }
    return null;
  }

  Future<void> cancelRecording() async {
    if (_isRecording) {
      await _audioStreamSubscription?.cancel(); // Stop listening
      _audioStreamSubscription = null;
      await _recordInstance.stop(); // Stop the underlying recorder hardware
      _isRecording = false;
      _audioBytes.clear(); // Discard collected bytes
      print('Recording cancelled. Bytes discarded.');
    }
  }

  Future<void> dispose() async {
    await _audioStreamSubscription
        ?.cancel(); // Ensure subscription is cancelled
    await _recordInstance.dispose(); // Dispose the recorder instance
    _audioBytes.clear();
  }
}
