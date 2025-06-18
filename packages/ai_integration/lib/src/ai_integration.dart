import 'dart:convert';
import 'dart:typed_data';

import 'package:ai_integration/src/audio_analysis.dart';
import 'package:ai_integration/src/image_analysis.dart';
import 'package:ai_integration/src/instruction_and_prompt.dart';
import 'package:ai_integration/src/text_analysis.dart';
import 'package:firebase_ai/firebase_ai.dart';

final class AiIntegration {
  const AiIntegration._();

  static final instance = AiIntegration._();

  AudioAnalysisAI audioAnalysisAI() {
    return AudioAnalysisAI(
      systemInstruction: InstructionAndPrompt.understandSearchInstruction,
      prompt: InstructionAndPrompt.audioTextAnalysisPrompt(),
    );
  }

  TextAnalysis textAnalysis(String text) {
    return TextAnalysis(
      systemInstruction: InstructionAndPrompt.understandSearchInstruction,
      prompt: InstructionAndPrompt.audioTextAnalysisPrompt(text: text),
    );
  }

  Future<ProductAnalysisGenerated> imageAnalysis(
    List<({String mimeType, Uint8List bytes})> imageData,
  ) async {
    final List<InlineDataPart> images = [];

    for (final image in imageData) {
      images.add(InlineDataPart(image.mimeType, image.bytes));
    }

    final ai = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.0-flash',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: Schema.object(
          properties: {
            'name': Schema.string(description: 'Product name'),
            'description': Schema.string(
              description:
                  'A details decription of the product in a friendly marketing style format',
            ),
            'category': Schema.string(),
            'subcategory': Schema.string(),
            'specs': Schema.array(
              items: Schema.string(),
              description: 'a map of the specification and their value if no ',
            ),
          },
        ),
      ),
    );

    const analysisPrompt = """
        Analyze the provided product images and generate comprehensive product information.
        
        
        Please provide:
        1. Main product category and subcategory
        2. Detailed specifications (dimensions, materials, colors, technical specs, etc.)
        3. A compelling product name
        4. A marketing description (2-3 sentences)
        
        Be specific and accurate in your analysis. If you cannot determine certain specifications from the images, indicate this clearly.
        
        Format your response as a JSON object matching the required schema.
      """;

    final response = await ai.generateContent([
      Content.multi(images),
      Content.text(analysisPrompt),
    ]);
    if (response.text == null) throw ('response text null');
    final json = jsonDecode(response.text!) as Map<String, dynamic>;
    return ProductAnalysisGenerated.fromJson(json);
  }
}

final class ProductAnalysisGenerated {
  final String name;
  final String description;
  final String category;
  final String subcategory;
  final List<String> specs;

  const ProductAnalysisGenerated({
    required this.name,
    required this.description,
    required this.category,
    required this.subcategory,
    required this.specs,
  });

  factory ProductAnalysisGenerated.fromJson(Map<String, dynamic> json) {
    return ProductAnalysisGenerated(
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String,
      specs: List<String>.from(json['specs']),
    );
  }
}
