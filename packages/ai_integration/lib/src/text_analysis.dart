import 'package:firebase_ai/firebase_ai.dart';
import 'package:functions/functions.dart';

import 'models/models.dart';

final class TextAnalysis {
  TextAnalysis({required String systemInstruction, required String prompt})
    : _prompt = prompt,
      _model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.0-flash',
        systemInstruction: Content.text(systemInstruction),
      );
  final GenerativeModel _model;
  final String _prompt;

  Future<String> sendText(String prompt) async {
    return MooemartFunctions.instance.productSearch(text: prompt);
    try {
      final response = await _model.generateContent([Content.text(_prompt)]);
      if (response.text == null) {
        throw AnalysisResponseException('No response found');
      }
      return response.text!;
    } catch (e) {
      throw AnalysisResponseException('Failed to analyze text: $e');
    }
  }
}
