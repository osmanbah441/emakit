import 'dart:async';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

enum _AudioInputMode { idle, typing, recording }

class AudioTextInputField extends StatefulWidget {
  final void Function(String)? onTextChanged;
  final VoidCallback onMicTap;
  final VoidCallback onSendText;
  final VoidCallback onSendRecording;
  final VoidCallback onCancelRecording;
  final VoidCallback onFilterTap;
  final Stream<({double current, double max})> amplitudeStream;
  final bool isSearching;

  const AudioTextInputField({
    super.key,
    this.onTextChanged,
    required this.onMicTap,
    required this.onSendText,
    required this.onSendRecording,
    required this.onCancelRecording,
    required this.amplitudeStream,
    required this.onFilterTap,
    this.isSearching = false,
  });

  @override
  State<AudioTextInputField> createState() => _AudioTextInputFieldState();
}

class _AudioTextInputFieldState extends State<AudioTextInputField> {
  late TextEditingController _controller;
  _AudioInputMode _internalMode = _AudioInputMode.idle;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onControllerTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerTextChanged);
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

  void _onControllerTextChanged() {
    if (_controller.text.isNotEmpty) {
      _setInternalMode(_AudioInputMode.typing);
    } else if (_controller.text.isEmpty) {
      _setInternalMode(_AudioInputMode.idle);
    }
    widget.onTextChanged?.call(_controller.text);
  }

  Widget _buildInputControl() => switch (_internalMode) {
    _AudioInputMode.idle => Row(
      children: [
        MicButton(
          onTap: () {
            _setInternalMode(_AudioInputMode.recording);
            widget.onMicTap();
          },
        ),
        IconButton(
          onPressed: widget.onFilterTap,
          icon: Icon(Icons.filter_list),
        ),
      ],
    ),

    _AudioInputMode.typing => IconButton(
      icon: const Icon(Icons.send),
      onPressed: () {
        widget.onSendText();
        _controller.clear();
        _setInternalMode(_AudioInputMode.idle);
      },
    ),

    _AudioInputMode.recording => Row(
      children: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            _setInternalMode(_AudioInputMode.idle);
            widget.onCancelRecording(); // Call client's handler
          },
        ),
        MicButton(
          onTap: () {
            widget.onSendRecording();
            _setInternalMode(_AudioInputMode.idle);
          },
          isRecording: true,
        ),
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
                ? AudioInputWaveform(amplitudeStream: widget.amplitudeStream)
                : TextField(
                    controller: _controller,
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
