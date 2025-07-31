import 'dart:typed_data';

import 'package:flutter/material.dart';

class DisplayMemoryImage extends StatelessWidget {
  const DisplayMemoryImage({
    super.key,
    required this.imageBytes,
    required this.onRemove,
    this.width = 160,
    this.height = 160,
  });
  final Uint8List imageBytes;
  final VoidCallback onRemove;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.memory(
            imageBytes,
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 16, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
