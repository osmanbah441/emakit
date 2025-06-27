import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final double height;

  const ImagePlaceholder({
    super.key,
    required this.onTap,
    this.width = 200,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondaryContainer;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: color, width: 4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo_outlined, // More inviting icon
              size: height * 0.4,
              color: color,
            ),
            SizedBox(height: height * 0.05),
            Text(
              'Tap to Select Image',
              style: TextStyle(
                fontSize: height * 0.07,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
