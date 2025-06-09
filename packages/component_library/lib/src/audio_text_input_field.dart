import 'dart:async';
import 'package:component_library/src/audio_input_controls.dart';
import 'package:component_library/src/audio_input_wave_form.dart';
import 'package:flutter/material.dart';

enum InputMode {
  idle,
  typing,
  recording,
  processing, // New state for when sending data
}

class AudioTextInputField extends StatelessWidget {
  final InputMode mode;
  final TextEditingController controller;
  final void Function(String) onTextChanged;
  final VoidCallback onMicTap;
  final VoidCallback onSendText;
  final VoidCallback onSendRecording;
  final VoidCallback onCancelRecording;

  final Stream<WaveformAmplitude> amplitudeStream;

  const AudioTextInputField({
    super.key,
    required this.mode,
    required this.controller,
    required this.onTextChanged,
    required this.onMicTap,
    required this.onSendText,
    required this.onSendRecording,
    required this.onCancelRecording,
    required this.amplitudeStream,
  });

  @override
  Widget build(BuildContext context) {
    bool isRecording = mode == InputMode.recording;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: isRecording
                ? AudioInputWaveform(amplitudeStream: amplitudeStream)
                : TextField(
                    controller: controller,
                    onChanged: onTextChanged,
                    decoration: const InputDecoration(
                      hintText: "Search...",
                      border: InputBorder.none,
                    ),
                  ),
          ),
          AudioInputControls(
            mode: mode,
            onMicTap: onMicTap,
            onSendText: onSendText,
            onSendRecording: onSendRecording,
            onCancelRecording: onCancelRecording,
          ),
        ],
      ),
    );
  }
}
