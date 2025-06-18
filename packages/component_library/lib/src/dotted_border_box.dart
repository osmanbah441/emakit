import 'dart:ui';
import 'package:flutter/material.dart';

class DottedBorderBox extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final BorderRadius borderRadius;

  const DottedBorderBox({
    super.key,
    required this.child,
    this.color = Colors.grey,
    this.strokeWidth = 2.0,
    this.dashPattern = const [5, 5], // 5 units on, 5 units off
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: borderRadius,
      ),
      child: CustomPaint(
        painter: _DottedBorderPainter(
          color: color,
          strokeWidth: strokeWidth,
          dashPattern: dashPattern,
          borderRadius: borderRadius,
        ),
        child: Center(child: child),
      ),
    );
  }
}

// Custom Painter for the Dotted Border
class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final BorderRadius borderRadius;

  _DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromRectAndCorners(
      Offset.zero & size,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    _drawDashedRRect(canvas, rRect, paint);
  }

  void _drawDashedRRect(Canvas canvas, RRect rRect, Paint paint) {
    final Path path = Path();
    path.addRRect(rRect);

    final PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double currentLength = 0;
      while (currentLength < pathMetric.length) {
        double dash = dashPattern[0];
        double gap = dashPattern.length > 1 ? dashPattern[1] : dashPattern[0];

        // Ensure we don't draw past the end of the path
        double end = currentLength + dash;
        if (end > pathMetric.length) {
          dash = pathMetric.length - currentLength;
          end = pathMetric.length; // Adjust end point
        }

        canvas.drawPath(pathMetric.extractPath(currentLength, end), paint);
        currentLength += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DottedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashPattern != dashPattern ||
        oldDelegate.borderRadius != borderRadius;
  }
}
