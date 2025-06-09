import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

// Define a simple class for amplitude values that the waveform widget can understand
class WaveformAmplitude {
  final double current;
  final double max;

  WaveformAmplitude({required this.current, required this.max});
}

class AudioInputWaveform extends StatefulWidget {
  final Stream<WaveformAmplitude> amplitudeStream;

  // Customizable properties for the waveform bars
  final int numberOfBars;
  final Color barColor;
  final BorderRadius barBorderRadius;
  final double minBarHeight;
  final double maxBarHeight;
  final Duration barAnimationDuration;
  final Curve barAnimationCurve;
  final double gapBetweenBars; // Spacing between bars

  const AudioInputWaveform({
    super.key,
    required this.amplitudeStream,
    this.numberOfBars = 60, // Default: More bars for a denser look
    this.barColor = Colors.deepOrange, // Default: Original color
    this.barBorderRadius = const BorderRadius.all(
      Radius.circular(2),
    ), // Default: Original rounding
    this.minBarHeight = 0.5, // Default: Very subtle minimum height for silence
    this.maxBarHeight = 35.0, // Default: Max height within the 40px container
    this.barAnimationDuration = const Duration(
      milliseconds: 80,
    ), // Default: Snappier animation
    this.barAnimationCurve =
        Curves.easeInOutSine, // Default: Smooth easing curve
    this.gapBetweenBars = 1.0, // Default: 1 pixel gap
  });

  @override
  State<AudioInputWaveform> createState() => _AudioInputWaveformState();
}

class _AudioInputWaveformState extends State<AudioInputWaveform> {
  // The list of heights will now be initialized based on widget.numberOfBars
  late final List<double> _heights;
  StreamSubscription<WaveformAmplitude>? _amplitudeSubscription;

  @override
  void initState() {
    super.initState();
    // Initialize _heights list using the customizable numberOfBars
    _heights = List.filled(widget.numberOfBars, 0.0);

    // Subscribe to the incoming amplitude stream.
    _amplitudeSubscription = widget.amplitudeStream.listen(
      (waveformAmp) {
        setState(() {
          // Normalize amplitude using waveformAmp.current.
          // We map dBFS (e.g., -60 dB for silence, 0 dB for max) to a 0.0-1.0 range.
          double normalizedAmplitude = ((waveformAmp.current + 60.0) / 60.0)
              .clamp(0.0, 1.0);

          // Shift existing heights to the left to create a "scrolling" effect.
          for (int i = 0; i < widget.numberOfBars - 1; i++) {
            _heights[i] = _heights[i + 1];
          }
          // Add the new normalized amplitude value to the end of the list.
          _heights[widget.numberOfBars - 1] = normalizedAmplitude;
        });
      },
      onDone: () {
        // When the amplitude stream is done (e.g., recording stopped/cancelled),
        // smoothly reset the waveform to flat.
        setState(() {
          _heights.fillRange(0, widget.numberOfBars, 0.0);
        });
      },
      onError: (e) {
        // Log errors from the stream for debugging.
        print("Error in AudioInputWaveform stream: $e");
        // Reset waveform on error to indicate an issue.
        setState(() {
          _heights.fillRange(0, widget.numberOfBars, 0.0);
        });
      },
    );
  }

  @override
  void dispose() {
    _amplitudeSubscription
        ?.cancel(); // Important: Cancel the stream subscription to prevent memory leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // Fixed height for the waveform area.
      width: double.infinity, // Take full available width for the waveform.
      child: LayoutBuilder(
        // Use LayoutBuilder to get the available width dynamically
        builder: (context, constraints) {
          final double totalWidth = constraints.maxWidth;

          // Calculate the width for each individual bar.
          // We subtract the total gap space from the total width, then divide by the number of bars.
          // Ensure numberOfBars is at least 1 to prevent division by zero.
          final double barWidth =
              (totalWidth - (widget.numberOfBars - 1) * widget.gapBetweenBars) /
              max(1, widget.numberOfBars);

          return Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Distribute bars evenly across the width
            children: _heights.map((normalizedAmplitude) {
              // Calculate the actual bar height for display using customizable min/max.
              final double barHeight =
                  (normalizedAmplitude * widget.maxBarHeight).clamp(
                    widget.minBarHeight,
                    widget.maxBarHeight,
                  );
              return AnimatedContainer(
                duration:
                    widget.barAnimationDuration, // Use customizable duration
                curve: widget.barAnimationCurve, // Use customizable curve
                width: barWidth.isFinite && barWidth > 0
                    ? barWidth
                    : 2.0, // Use calculated width, fallback to 2.0 if not finite or zero
                height: barHeight,
                decoration: BoxDecoration(
                  color: widget.barColor, // Use customizable color
                  borderRadius:
                      widget.barBorderRadius, // Use customizable border radius
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
