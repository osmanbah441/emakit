import 'package:ai_integration/src/models/models.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:functions/functions.dart';

import 'utils/ai_recorder/ai_recorder.dart';

class AudioAnalysisAI {
  AudioAnalysisAI({required String systemInstruction, required this.prompt})
    : _model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.0-flash-lite-001',
        systemInstruction: Content.text(systemInstruction),
      );

  final String prompt;
  final _recorder = AiRecorder();
  final GenerativeModel _model;

  Stream<({double current, double max})> get getamplitudeStream =>
      _recorder.getamplitudeStream;

  Future<void> startRecording() async => await _recorder.startRecording();

  Future<void> cancelRecording() async => await _recorder.cancelRecording();

  Future<String> sendRecording() async {
    final recordedBytes = await _recorder.stopRecording();

    return MooemartFunctions.instance.productSearch(
      media: (bytes: recordedBytes, mimeType: 'audio/wav'),
    );

    final content = Content.multi([
      InlineDataPart('audio/wav', recordedBytes),
      TextPart(prompt),
    ]);

    try {
      final response = await _model.generateContent([content]);
      // TODO: handle response later: Osman Bah for tools and other check
      if (response.text == null) {
        throw AnalysisResponseException('No response found');
      }
      return response.text!;
    } catch (e) {
      throw AnalysisResponseException('Failed to analyze audio: $e');
    }
  }

  Future<void> dispose() => _recorder.dispose();
}
