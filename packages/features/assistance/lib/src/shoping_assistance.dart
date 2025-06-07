import 'package:flutter/material.dart';
import 'package:ai/ai.dart';

class ShoppingAssistantScreen extends StatefulWidget {
  const ShoppingAssistantScreen({super.key});

  @override
  State<ShoppingAssistantScreen> createState() =>
      _ShoppingAssistantScreenState();
}

class _ShoppingAssistantScreenState extends State<ShoppingAssistantScreen> {
  final _liveModel = AIService.instance.liveModel;
  bool _isCalling = false; // State to track if a call is active

  @override
  void initState() {
    super.initState();
    _liveModel.initialize();
  }

  @override
  void dispose() {
    _liveModel.dispose();
    super.dispose();
  }

  void _toggleCall() {
    setState(() {
      _isCalling = !_isCalling;
    });

    if (_isCalling) {
      // Start the session
      _liveModel.startSession();
      print('Shopping assistant session started!');
    } else {
      // End the session
      _liveModel.stopSession();
      print('Shopping assistant session ended.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('e-makit Shopping Assistant'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _isCalling
                  ? 'Conversation with e-makit AI in progress...'
                  : 'Tap the button to start a session with e-makit AI.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _toggleCall,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCalling ? Colors.redAccent : Colors.green,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(30),
              ),
              child: Icon(
                _isCalling ? Icons.call_end : Icons.call,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _isCalling ? 'End Session' : 'Start Session',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _isCalling ? Colors.redAccent : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
