import 'package:flutter/material.dart';

// enum AudioState { idle, recording, thinking }

class MicButton extends StatefulWidget {
  final bool isRecording;
  final VoidCallback onTap;
  const MicButton({super.key, this.isRecording = false, required this.onTap});

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
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _pulse,
      builder: (_, __) {
        final double glow = widget.isRecording ? _pulse.value * 12 : 0;
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              if (widget.isRecording)
                BoxShadow(
                  color: colorScheme.primaryContainer,
                  blurRadius: glow,
                  spreadRadius: glow / 2,
                ),
            ],
          ),
          child: IconButton(
            onPressed: widget.onTap,
            icon: Icon(
              Icons.mic_outlined,
              color: widget.isRecording ? colorScheme.secondaryContainer : null,
            ),
          ),
        );
      },
    );
  }
}
