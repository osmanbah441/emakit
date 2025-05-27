// lib/widgets/voice_input_button.dart
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class VoiceInputButton extends StatefulWidget {
  final Function(String) onResult;
  final Function(bool) onListeningChanged; // Callback for listening state

  const VoiceInputButton({
    super.key,
    required this.onResult,
    required this.onListeningChanged,
  });

  @override
  _VoiceInputButtonState createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends State<VoiceInputButton> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    var microStatus = await Permission.microphone.request();

    if (microStatus.isGranted) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if (val == stt.SpeechToText.listeningStatus) {
            setState(() => _isListening = true);
            widget.onListeningChanged(true);
          } else if (val == stt.SpeechToText.notListeningStatus ||
              val == stt.SpeechToText.doneStatus) {
            setState(() => _isListening = false);
            widget.onListeningChanged(false);
            _speech.stop();
          }
        },
        onError: (val) {
          print('onError: $val');
          setState(() => _isListening = false);
          widget.onListeningChanged(false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Speech recognition error: ${val.errorMsg}'),
            ),
          );
        },
      );
      if (available) {
        setState(() => _isListening = true);
        widget.onListeningChanged(true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.finalResult) {
              widget.onResult(_text);
              setState(
                () => _isListening = false,
              ); // Stop listening visually after final result
              widget.onListeningChanged(false);
            }
          }),
          localeId: 'en_US', // Specify your locale
          listenFor: const Duration(seconds: 10), // Max listen duration
          pauseFor: const Duration(
            seconds: 3,
          ), // Pause before considering speech ended
        );
      } else {
        print("The user has denied the use of speech recognition.");
        setState(() => _isListening = false);
        widget.onListeningChanged(false);
      }
    } else {
      print("Microphone permission not granted");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Microphone permission is required for voice input.'),
        ),
      );
    }
  }

  void _stopListen() {
    _speech.stop();
    setState(() => _isListening = false);
    widget.onListeningChanged(false);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
      iconSize: 28,
      onPressed: _isListening ? _stopListen : _listen,
      tooltip: 'Tap to speak',
    );
  }
}
