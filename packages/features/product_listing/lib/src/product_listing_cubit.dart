import 'dart:convert';
import 'dart:typed_data';

import 'package:ai_integration/ai_integration.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_listing_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState());

  void updateGeneratedInfo({
    required String name,
    required String description,
    required Map<String, String> specs,
    required String category,
  }) {
    emit(
      state.copyWith(
        name: name,
        description: description,
        specs: specs,
        category: category,
      ),
    );
  }

  void updateSpecs(Map<String, String> specs) {
    emit(state.copyWith(specs: specs));
  }

  void nextStep() {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void previousStep() {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void goToStep(int step) {
    emit(state.copyWith(currentStep: step));
  }

  void uploadImages(
    List<({String mimeType, Uint8List bytes})> imageData,
  ) async {
    // emit(state.copyWith(loading: true));
    final ai = await AiIntegration.instance.imageAnalysis(imageData);
    print(ai.specs);
    //   final List<InlineDataPart> images = [];

    //   for (final image in imageData) {
    //     images.add(InlineDataPart(image.mimeType, image.bytes));
    //   }

    //   final ai = FirebaseAI.googleAI().generativeModel(
    //     model: 'gemini-2.0-flash',
    //     generationConfig: GenerationConfig(
    //       responseMimeType: 'application/json',
    //       responseSchema: Schema.object(
    //         properties: {
    //           'name': Schema.string(),
    //           'description': Schema.string(),
    //           'category': Schema.string(),
    //           'subcategory': Schema.string(),
    //           'specs': Schema.array(items: Schema.string()),
    //         },
    //       ),
    //     ),
    //   );

    //   const analysisPrompt = """
    //       Analyze the provided product images and generate comprehensive product information.

    //       Please provide:
    //       1. Main product category and subcategory
    //       2. Detailed specifications (dimensions, materials, colors, technical specs, etc.)
    //       3. A compelling product name
    //       4. A marketing description (2-3 sentences)

    //       Be specific and accurate in your analysis. If you cannot determine certain specifications from the images, indicate this clearly.

    //       Format your response as a JSON object matching the required schema.
    //     """;

    //   final response = await ai.generateContent([
    //     Content.multi(images),
    //     Content.text(analysisPrompt),
    //   ]);
    //   if (response.text == null) throw ('response text null');
    //   final json = jsonDecode(response.text!) as Map<String, dynamic>;
    //   print(json);

    //   emit(
    //     state.copyWith(
    //       category: json['category'] as String,
    //       name: json['name'] as String,
    //       description: json['description'] as String,
    //       requiredSpecsByCategory: json["specs"] as List<String>,
    //       loading: false,
    //     ),
    //   );
  }
}
