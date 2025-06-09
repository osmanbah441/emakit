import 'package:flutter/material.dart';

import 'audio_text_input_field.dart';
import 'mic_button.dart';

class AudioInputControls extends StatelessWidget {
  final InputMode mode;
  final VoidCallback onMicTap;
  final VoidCallback onSendText;
  final VoidCallback onSendRecording;
  final VoidCallback onCancelRecording;
  final VoidCallback onFilterTap;

  const AudioInputControls({
    super.key,
    required this.mode,
    required this.onMicTap,
    required this.onSendText,
    required this.onSendRecording,
    required this.onCancelRecording,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case InputMode.recording:
        return Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onCancelRecording,
            ),
            MicButton(onTap: onSendRecording, isRecording: true),
          ],
        );
      case InputMode.typing:
        return IconButton(icon: const Icon(Icons.send), onPressed: onSendText);
      case InputMode.idle:
        return Row(
          children: [
            MicButton(onTap: onMicTap),
            IconButton(onPressed: onFilterTap, icon: Icon(Icons.filter_list)),
          ],
        );
      case InputMode.processing:
        return const SizedBox.shrink();
    }
  }
}
