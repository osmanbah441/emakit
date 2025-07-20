import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

class StoreDashboardScreen extends StatelessWidget {
  const StoreDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LlmChatView(
        style: LlmChatViewStyle(),
        responseBuilder: (context, response) {
          return Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(response, style: const TextStyle(fontSize: 16)),
            ),
          );
        },

        provider: FirebaseProvider(
          chatGenerationConfig: GenerationConfig(
            responseMimeType: 'text/plain',
            responseModalities: [ResponseModalities.text],
          ),
          model: FirebaseAI.googleAI().generativeModel(
            tools: [],

            model: 'gemini-2.5-flash',
          ),
        ),
      ),
    );
  }
}
