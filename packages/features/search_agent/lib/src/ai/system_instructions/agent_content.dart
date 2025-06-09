import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';

part 'audio_search_instruction.dart';
part 'text_search_instruction.dart';

final class AgentContent {
  static Content audioContent(Uint8List bytes) => Content.multi([
    InlineDataPart('audio/wav', bytes),
    TextPart(_audioPromptText),
  ]);

  static Content textContent(String text) =>
      Content.text(_buildTextPrompt(text));

  static Content audioInstruction = Content.text(_audioSearchInstruction);
  static Content textInstruction = Content.text(_textSearchInstruction);
}
