import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioTextBanner extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final String audioUrl;
  final String textInstruction;

  const AudioTextBanner({
    super.key,
    required this.audioPlayer,
    required this.audioUrl,
    required this.textInstruction,
  });

  @override
  State<AudioTextBanner> createState() => _AudioTextBannerState();
}

class _AudioTextBannerState extends State<AudioTextBanner> {
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _loadAudio();
    widget.audioPlayer.playerStateStream.listen((playerState) {
      if (mounted && playerState.playing != _isPlaying) {
        setState(() {
          _isPlaying = playerState.playing;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant AudioTextBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.audioUrl != oldWidget.audioUrl) {
      _loadAudio();
    }
  }

  Future<void> _loadAudio() async {
    try {
      await widget.audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(widget.audioUrl)),
      );
      // No auto-play here, user can press play
    } catch (e) {
      print("Error loading audio: $e");
      // Handle audio loading error (e.g., show a snackbar)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Layer (at the top)
          Text(
            widget.textInstruction,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12.0), // Space between text and audio controls
          // Audio Player Controls (at the bottom)
          Row(
            children: [
              IconButton(
                icon: Icon(
                  _isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: Colors.blue,
                  size: 32.0,
                ),
                onPressed: () {
                  if (_isPlaying) {
                    widget.audioPlayer.pause();
                  } else {
                    widget.audioPlayer.play();
                  }
                },
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: StreamBuilder<Duration?>(
                  stream: widget.audioPlayer.durationStream,
                  builder: (context, snapshot) {
                    final duration = snapshot.data ?? Duration.zero;
                    return StreamBuilder<Duration>(
                      stream: widget.audioPlayer.positionStream,
                      builder: (context, snapshot) {
                        var position = snapshot.data ?? Duration.zero;
                        if (position > duration) {
                          position = duration;
                        }
                        return Slider(
                          min: 0.0,
                          max: duration.inMilliseconds.toDouble(),
                          value: position.inMilliseconds.toDouble(),
                          onChanged: (value) {
                            widget.audioPlayer.seek(
                              Duration(milliseconds: value.toInt()),
                            );
                          },
                          activeColor: Colors.blue,
                          inactiveColor: Colors.blue.shade100,
                        );
                      },
                    );
                  },
                ),
              ),
              Text(
                '${_formatDuration(widget.audioPlayer.position)} / ${_formatDuration(widget.audioPlayer.duration ?? Duration.zero)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
