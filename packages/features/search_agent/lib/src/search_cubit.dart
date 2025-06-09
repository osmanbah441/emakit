import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:record/record.dart';

import 'ai/system_instructions/agent_content.dart';
import 'utils/waveform_amplitude.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchIdle());

  final _recorder = AudioRecorder();

  Stream<WaveformAmplitude> get getamplitudeStream => _recorder
      .onAmplitudeChanged(const Duration(milliseconds: 100))
      .map((amp) => WaveformAmplitude(current: amp.current, max: amp.max));

  Future<void> startRecording() async {
    if (!(await _recorder.hasPermission())) return;
    emit(SearchRecording());

    final recordConfig = RecordConfig(
      encoder: AudioEncoder.wav,
      sampleRate: 24000,
      numChannels: 1,
      echoCancel: true,
      noiseSuppress: true,
    );
    if (kIsWeb) await _recorder.start(recordConfig, path: '');
  }

  void textChanged(String text) {
    if (text.trim().isEmpty) {
      emit(SearchIdle());
    } else {
      emit(SearchTyping());
    }
  }

  Future<void> cancelRecording() async {
    await _recorder.stop();
    emit(SearchIdle());
  }

  Future<void> sendRecording() async {
    final path = await _recorder.stop(); // This is a blob URL on web

    emit(SearchSuccess(path ?? 'No path found'));
    emit(SearchProcessing());

    if (path == null || !path.startsWith('blob:')) {
      emit(SearchError('Invalid recording path.'));
      return;
    }

    final recordedBytes = await readBytesFromBlobUrl(path);
    if (recordedBytes == null) {
      emit(SearchError('Failed to read recorded audio.'));
      return;
    }

    _agent('gemini-2.0-flash-lite-001', audio: recordedBytes);

    // try {
    //   final response = await _model.generateContent([
    //     Content.multi([
    //       InlineDataPart('audio/wav', recordedBytes),
    //       TextPart("Tell me in simple term what the customer is saying."),
    //     ]),
    //   ]);
    //   emit(SearchSuccess(response.text ?? 'No response.'));
    // } catch (e) {
    //   emit(SearchError('Send failed: ${e.toString()}'));
    // }
  }

  Future<Uint8List?> readBytesFromBlobUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (e) {
      print('Error fetching blob URL: $e');
    }
    return null;
  }

  void _agent(String geminiModel, {String? text, Uint8List? audio}) async {
    if (text == null && audio == null) return;
    if (text != null && audio != null) return;
    emit(SearchProcessing());

    final model = FirebaseAI.vertexAI().generativeModel(
      model: geminiModel,
      systemInstruction: (audio != null)
          ? AgentContent.audioInstruction
          : AgentContent.textInstruction,
    );

    final content = audio != null
        ? AgentContent.audioContent(audio)
        : AgentContent.textContent(text!);

    try {
      final response = await model.generateContent([content]);
      emit(SearchSuccess(response.text ?? 'No response.'));
    } catch (e) {
      emit(SearchError('Send failed: ${e.toString()}'));
    }
  }

  Future<void> sendText(String text) async {
    if (text.trim().isNotEmpty) {
      _agent('gemini-2.0-flash-lite-001', text: text);
    } else {
      emit(SearchIdle());
    }
  }

  @override
  Future<void> close() {
    _recorder.dispose();
    return super.close();
  }
}
