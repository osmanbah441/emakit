import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:record/record.dart';

typedef OnStateChanged =
    void Function(
      bool isSettingUp,
      bool sessionOpened,
      bool conversationActive,
    );

typedef OnTextMessageReceived = void Function(String text);

typedef OnFunctionCallReceived =
    void Function(List<FunctionCall> functionCalls);

typedef OnTurnComplete = void Function();

typedef OnError = void Function(String error);

typedef OnAudioReadyStateChanged = void Function(bool audioReady);

class LiveConversionService {
  final LiveGenerativeModel _liveModel;
  final AudioRecorder _recorder = AudioRecorder();
  late final SoLoud _soLoud;

  LiveSession? _session;
  StreamController<bool>? _stopProcessingController;
  StreamSubscription<Uint8List>? _recordingSubscription;
  StreamSubscription<LiveServerResponse>? _sessionSubscription;

  // Callbacks
  final OnStateChanged? onStateChanged;
  final OnTextMessageReceived? onTextMessageReceived;
  final OnFunctionCallReceived? onFunctionCallReceived;
  final OnTurnComplete? onTurnComplete;
  final OnError? onError;
  final OnAudioReadyStateChanged? onAudioReadyStateChanged;

  // Internal state flags
  bool _sessionOpened = false;
  bool _isSettingUpSession = false;
  bool _conversationActive = false;
  bool _audioReady = false;

  // SoLoud specific
  AudioSource? _audioSource;
  SoundHandle? _soundHandle;

  LiveConversionService({
    required String systemInstruction,
    required String modelName,
    required List<Tool> tools,
    this.onStateChanged,
    this.onTextMessageReceived,
    this.onFunctionCallReceived,
    this.onTurnComplete,
    this.onError,
    this.onAudioReadyStateChanged,
  }) : _liveModel = FirebaseAI.vertexAI().liveGenerativeModel(
         systemInstruction: Content.text(systemInstruction),
         model: modelName,
         liveGenerationConfig: LiveGenerationConfig(
           speechConfig: SpeechConfig(voiceName: 'fenrir'),
           responseModalities: [ResponseModalities.audio],
         ),
         tools: tools,
       ) {
    _soLoud = SoLoud.instance;
  }

  void _updateState() {
    onStateChanged?.call(
      _isSettingUpSession,
      _sessionOpened,
      _conversationActive,
    );
  }

  Future<void> initializeAudio() async {
    try {
      await _checkMicPermission();
      await _soLoud.init(sampleRate: 24000, channels: Channels.mono);
      _audioReady = true;
      onAudioReadyStateChanged?.call(true);
      log("Audio initialized successfully by LiveConversionService");
    } catch (e) {
      log("Error during audio initialization in LiveConversionService: $e");
      onError?.call("Error initializing audio: ${e.toString()}");
      _audioReady = false;
      onAudioReadyStateChanged?.call(false);
    }
  }

  bool get isAudioReady => _audioReady;
  bool get isConversationActive => _conversationActive;

  Future<void> toggleConversation() async {
    if (_conversationActive) {
      await stopConversation();
    } else {
      await startConversation();
    }
  }

  Future<void> startConversation() async {
    if (!_audioReady) {
      onError?.call("Audio system is not ready. Cannot start conversation.");
      log("Audio system not ready in LiveConversionService.");
      return;
    }
    if (_isSettingUpSession || _conversationActive) return;

    _isSettingUpSession = true;
    _updateState();

    try {
      await _openLiveGeminiSession();

      final inputStream = await _startRecordingStream();
      log('Input stream should be recording in LiveConversionService!');

      Stream<InlineDataPart> inlineDataStream = inputStream.map((data) {
        return InlineDataPart('audio/pcm', data);
      });
      _session?.sendMediaStream(inlineDataStream);

      // Setup output audio stream
      _audioSource = _soLoud.setBufferStream(
        bufferingType: BufferingType.released,
        bufferingTimeNeeds: 0,
        onBuffering: (isBuffering, handle, time) {
          log('Buffering: $isBuffering, Time: $time');
        },
      );
      _soundHandle = await _soLoud.play(_audioSource!);
      log('Output stream should be playing in LiveConversionService!');

      _conversationActive = true;
    } catch (e) {
      log("Error starting conversation: $e");
      onError?.call("Failed to start conversation: ${e.toString()}");
      await stopConversation(); // Ensure cleanup on error
    } finally {
      _isSettingUpSession = false;
      _updateState();
    }
  }

  Future<void> stopConversation() async {
    await _stopRecording();

    if (_audioSource != null && _soundHandle != null) {
      _soLoud.setDataIsEnded(_audioSource!);
      await _soLoud.stop(_soundHandle!);
      _audioSource = null;
      _soundHandle = null;
    }

    await _closeLiveGeminiSession();

    _conversationActive = false;
    _isSettingUpSession = false; // Ensure setup flag is also reset
    _updateState();
    log('Conversation stopped in LiveConversionService.');
  }

  Future<void> _checkMicPermission() async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      throw Exception(
        'This app does not have microphone permissions. Please enable it.',
      );
    }
  }

  Future<Stream<Uint8List>> _startRecordingStream() async {
    var recordConfig = const RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: 24000,
      numChannels: 1,
      echoCancel: true,
      noiseSuppress: true,
      androidConfig: AndroidRecordConfig(
        audioSource: AndroidAudioSource.voiceCommunication,
      ),
      iosConfig: IosRecordConfig(
        categoryOptions: [IosAudioCategoryOption.defaultToSpeaker],
      ),
    );
    return await _recorder.startStream(recordConfig);
  }

  Future<void> _stopRecording() async {
    await _recorder.stop();
    await _recordingSubscription?.cancel();
    _recordingSubscription = null;
    log('Recording stopped in LiveConversionService.');
  }

  Future<void> _openLiveGeminiSession() async {
    if (_sessionOpened) return;

    _isSettingUpSession = true;
    _updateState();

    try {
      _session = await _liveModel.connect();
      _sessionOpened = true;
      log("Live Gemini session opened.");
      _stopProcessingController = StreamController<bool>();
      _processMessagesContinuously(_stopProcessingController!);
    } catch (e) {
      log("Error opening Gemini session: $e");
      onError?.call("Error connecting to AI: ${e.toString()}");
      _sessionOpened = false; // Ensure state is correct on error
      rethrow; // Rethrow to allow startConversation to handle cleanup
    } finally {
      _isSettingUpSession = false;
      _updateState();
    }
  }

  Future<void> _closeLiveGeminiSession() async {
    if (!_sessionOpened) return;

    _isSettingUpSession = true; // Indicate that we are changing session state
    _updateState();

    try {
      await _session?.close();
      _stopProcessingController?.add(true);
      await _stopProcessingController?.close();
      _stopProcessingController = null;
      await _sessionSubscription?.cancel();
      _sessionSubscription = null;
    } catch (e) {
      log("Error closing session: $e");
      onError?.call("Error closing AI session: ${e.toString()}");
    } finally {
      _sessionOpened = false;
      _session = null;
      _isSettingUpSession = false;
      _updateState();
      log("Live Gemini session closed.");
    }
  }

  Future<void> _processMessagesContinuously(
    StreamController<bool> stopSignal,
  ) async {
    bool shouldContinue = true;

    final stopSubscription = stopSignal.stream.listen((stop) {
      if (stop) {
        shouldContinue = false;
      }
    });

    try {
      _sessionSubscription = _session?.receive().listen(
        (response) {
          if (!shouldContinue) return;
          LiveServerMessage message = response.message;
          _handleLiveServerMessage(message);
        },
        onError: (e) {
          if (!shouldContinue) return;
          log("Error receiving message: ${e.toString()}");
          onError?.call("Error in AI communication: ${e.toString()}");
          // Consider closing session or attempting to recover
        },
        onDone: () {
          if (!shouldContinue) return;
          log("AI message stream closed by server.");
          if (_conversationActive) {
            // If conversation was active, this is unexpected
            onError?.call("AI connection closed unexpectedly.");
            stopConversation(); // Clean up
          }
        },
        cancelOnError: true, // Automatically cancels on error
      );

      await stopSubscription.asFuture(); // Keep alive until stop signal
    } catch (e) {
      log("Error in _processMessagesContinuously: ${e.toString()}");
      onError?.call("Critical error in message processing: ${e.toString()}");
    } finally {
      await stopSubscription.cancel(); // Clean up stop signal listener
      await _sessionSubscription?.cancel(); // Clean up session message listener
      _sessionSubscription = null;
      log("_processMessagesContinuously ended.");
    }
  }

  Future<void> _handleLiveServerMessage(LiveServerMessage response) async {
    if (response is LiveServerContent) {
      if (response.modelTurn != null) {
        _handleLiveServerContent(response);
      }
      if (response.turnComplete != null && response.turnComplete!) {
        onTurnComplete?.call();
        log('Model turn complete reported by LiveConversionService.');
      }
      if (response.interrupted != null && response.interrupted!) {
        log('Interrupted: $response');
        onError?.call("Conversation was interrupted.");
      }
    } else if (response is LiveServerToolCall &&
        response.functionCalls != null) {
      onFunctionCallReceived?.call(response.functionCalls!);
      log(
        'Function call reported by LiveConversionService: ${response.functionCalls!.map((fc) => fc.name)}',
      );
    }
  }

  void _handleLiveServerContent(LiveServerContent response) {
    log('Received LiveServerContent from LiveConversionService.');
    final partList = response.modelTurn?.parts;
    if (partList != null) {
      for (final part in partList) {
        if (part is TextPart) {
          onTextMessageReceived?.call(part.text);
          log('Text message from Gemini (via Service): ${part.text}');
        } else if (part is InlineDataPart) {
          if (part.mimeType.startsWith('audio/')) {
            if (_audioSource != null) {
              _soLoud.addAudioDataStream(_audioSource!, part.bytes);
            } else {
              log("AudioSource is null, cannot play audio data.");
              onError?.call("Audio output not ready for AI response.");
            }
          }
        } else {
          log(
            'Received part with unhandled type ${part.runtimeType} in LiveConversionService',
          );
        }
      }
    }
  }

  Future<void> dispose() async {
    log("Disposing LiveConversionService...");
    await _stopRecording();
    await _closeLiveGeminiSession();
    _recorder.dispose();
    await _stopProcessingController?.close();
    await _sessionSubscription?.cancel();
    if (_audioReady) {
      await _soLoud.disposeAllSources();
      _audioReady = false;
      onAudioReadyStateChanged?.call(false);
    }
    log("LiveConversionService disposed.");
  }
}
