import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class AudioInputControls extends StatelessWidget {
  final InputMode mode;
  final VoidCallback onMicTap;
  final VoidCallback onSendText;
  final VoidCallback onSendRecording;
  final VoidCallback onCancelRecording;

  const AudioInputControls({
    super.key,
    required this.mode,
    required this.onMicTap,
    required this.onSendText,
    required this.onSendRecording,
    required this.onCancelRecording,
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
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: onSendRecording,
            ),
          ],
        );
      case InputMode.typing:
        return IconButton(icon: const Icon(Icons.send), onPressed: onSendText);
      case InputMode.idle:
        return IconButton(icon: const Icon(Icons.mic), onPressed: onMicTap);
      case InputMode.processing:
        return const CircularProgressIndicator();
      default:
        return const SizedBox.shrink();
    }
  }
}
