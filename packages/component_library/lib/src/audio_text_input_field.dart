import 'dart:async';
import 'dart:typed_data';
import 'package:component_library/component_library.dart';
import 'package:component_library/src/utils/mooemart_recorder.dart';
import 'package:flutter/material.dart';

enum _AudioInputMode { idle, typing, recording }

class AudioTextInputField extends StatefulWidget {
  final Function(String text) onSendText;
  final Function(String mimeType, Uint8List bytes) onSendRecording;
  final VoidCallback onFilterTap;
  final bool isSearching;

  const AudioTextInputField({
    super.key,
    required this.onSendText,
    required this.onSendRecording,
    required this.onFilterTap,
    this.isSearching = false,
  });

  @override
  State<AudioTextInputField> createState() => _AudioTextInputFieldState();
}

class _AudioTextInputFieldState extends State<AudioTextInputField> {
  late TextEditingController _controller;
  _AudioInputMode _internalMode = _AudioInputMode.idle;

  final _recorder = MooemartRecorder();

  Future<void> _startRecording() async {
    await _recorder.startRecording();
    _setInternalMode(_AudioInputMode.recording);
  }

  Future<void> _cancelRecording() async {
    await _recorder.cancelRecording();
    _setInternalMode(_AudioInputMode.idle);
  }

  Future<void> _sendRecording() async {
    final recordedBytes = await _recorder.stopRecording();
    widget.onSendRecording('audio/wav', recordedBytes);
    _setInternalMode(_AudioInputMode.idle);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _recorder.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _setInternalMode(_AudioInputMode newMode) {
    if (_internalMode != newMode) {
      setState(() {
        _internalMode = newMode;
      });
    }
  }

  Widget _buildInputControl() => switch (_internalMode) {
    _AudioInputMode.idle => Row(
      children: [
        MicButton(onTap: _startRecording),
        IconButton(
          onPressed: widget.onFilterTap,
          icon: Icon(Icons.filter_list),
        ),
      ],
    ),

    _AudioInputMode.typing => IconButton(
      icon: const Icon(Icons.send),
      onPressed: () {
        widget.onSendText(_controller.text);
        _controller.clear();
        _setInternalMode(_AudioInputMode.idle);
      },
    ),

    _AudioInputMode.recording => Row(
      children: [
        IconButton(icon: const Icon(Icons.close), onPressed: _cancelRecording),
        MicButton(onTap: _sendRecording, isRecording: true),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
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
            child: _internalMode == _AudioInputMode.recording
                ? AudioInputWaveform(
                    amplitudeStream: _recorder.getamplitudeStream,
                  )
                : TextField(
                    controller: _controller,
                    onChanged: (value) {
                      if (_controller.text.isNotEmpty) {
                        _setInternalMode(_AudioInputMode.typing);
                      } else {
                        _setInternalMode(_AudioInputMode.idle);
                      }
                    },
                    onSubmitted: (value) {
                      widget.onSendText(value);
                      _controller.clear();
                      _setInternalMode(_AudioInputMode.idle);
                    },
                    enabled: !widget.isSearching,
                    decoration: InputDecoration(
                      hintText: widget.isSearching
                          ? "Processing your request..."
                          : "Search for products or ask a question...",
                      border: InputBorder.none,
                    ),
                  ),
          ),
          _buildInputControl(),
        ],
      ),
    );
  }
}
