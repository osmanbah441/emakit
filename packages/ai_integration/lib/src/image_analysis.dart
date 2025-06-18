import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';

typedef ImageInput = ({String mimetype, Uint8List image});

final class ImageAnalysis {
  ImageAnalysis({required String systemInstruction, required String prompt})
    : _prompt = prompt,
      _model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.0-flash',
        systemInstruction: Content.text(systemInstruction),
      );
  final GenerativeModel _model;
  final String _prompt;

  Future sendImages(List<ImageInput> images) async {
    final prompt = TextPart(_prompt);

    final imageParts = images
        .map((i) => InlineDataPart(i.mimetype, i.image))
        .toList();

    // To generate text output, call generateContent with the text and image
    final response = await _model.generateContent([
      Content.multi([prompt, ...imageParts]),
    ]);
    print(response.text);
  }
}
