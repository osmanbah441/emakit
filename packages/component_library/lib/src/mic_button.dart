import 'package:flutter/material.dart';

enum AudioState { idle, recording, thinking }

class MicButton extends StatefulWidget {
  final AudioState state;
  final VoidCallback onTap;
  const MicButton({super.key, required this.state, required this.onTap});

  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 0.0, end: 1.0).animate(_pulseController);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRecording = widget.state == AudioState.recording;
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (_, __) {
          final double glow = isRecording ? _pulse.value * 12 : 0;
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                if (isRecording)
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.5),
                    blurRadius: glow,
                    spreadRadius: glow / 2,
                  ),
              ],
            ),
            child: Icon(
              Icons.mic,
              color: isRecording ? Colors.redAccent : Colors.black,
              size: 32,
            ),
          );
        },
      ),
    );
  }
}
