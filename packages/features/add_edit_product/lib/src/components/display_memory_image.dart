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
    return Stack(
      children: [
        Image.memory(
          imageBytes,
          width: width,
          height: height,
          // fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              icon: const Icon(Icons.close, size: 18, color: Colors.red),
              onPressed: onRemove,
            ),
          ),
        ),
      ],
    );
  }
}
