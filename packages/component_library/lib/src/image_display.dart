import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final String imageUrl;
  final String? heroTag; // Optional hero tag
  final double aspectRatio;
  final BorderRadiusGeometry borderRadius;
  final Widget? errorWidget; // Optional custom error widget

  const ImageDisplay({
    super.key,
    required this.imageUrl,
    this.heroTag,
    this.aspectRatio = 1.35,
    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(16)),
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    Widget imageWidget = ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? // Use custom error widget if provided, otherwise default
            Container(
              color: colorScheme.surfaceContainer,
              child: Center(
                child: Icon(Icons.image_not_supported_outlined, size: 60),
              ),
            ),
      ),
    );

    if (heroTag != null) {
      imageWidget = Hero(tag: heroTag!, child: imageWidget);
    }

    return AspectRatio(aspectRatio: aspectRatio, child: imageWidget);
  }
}
