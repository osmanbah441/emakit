import 'package:cached_network_image/cached_network_image.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class CachedProductImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final double? width;
  final double? height;

  const CachedProductImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        fadeInCurve: Curves.easeIn,
        width: width,
        height: height,
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) => CenteredProgressIndicator(),
        errorWidget: (context, url, error) => Center(
          child: Icon(Icons.broken_image, size: 50, color: Colors.grey[400]),
        ),
      ),
    );
  }
}
