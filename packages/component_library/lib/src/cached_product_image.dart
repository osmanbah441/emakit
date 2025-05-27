import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedProductImage extends StatelessWidget {
  final String imageUrl;
  final double aspectRatio;
  final BoxFit fit;
  final BorderRadius borderRadius;

  const CachedProductImage({
    super.key,
    required this.imageUrl,
    this.aspectRatio = 11 / 8,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Icon(Icons.broken_image, size: 50, color: Colors.grey[400]),
          ),
        ),
      ),
    );
  }
}
