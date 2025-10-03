import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class DisplayMemoryImage extends StatelessWidget {
  const DisplayMemoryImage({
    super.key,
    required this.imageBytes,
    required this.onRemove,
    this.width = 160,
    this.height = 160,
    this.borderRadius = BorderRadius.zero,
    this.imageBackgroundColor = const Color(0xFFF0F0F0),
  });

  final Uint8List imageBytes;
  final VoidCallback onRemove;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Color imageBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final double baseDimension = min(width, height);
    final double iconSize = baseDimension * 0.10;
    final double iconContainerSize = iconSize * 1.6;
    final double positionOffset = baseDimension * 0.05;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            width: width,
            height: height,
            color: imageBackgroundColor,
            child: Image.memory(imageBytes, fit: BoxFit.contain),
          ),
        ),
        Positioned(
          top: positionOffset,
          right: positionOffset,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: iconContainerSize,
              height: iconContainerSize,
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: iconSize, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
