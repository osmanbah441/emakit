// class WaveformAmplitude {
//   final double current;
//   final double max;

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class PromoBannerCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;
  final double aspectRatio;
  final double borderRadius;
  final double elevation;

  const PromoBannerCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    this.aspectRatio = 280 / 344, // width / height
    this.borderRadius = 16.0,
    this.elevation = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Semantics(
          label: title,
          button: onTap != null,
          image: true,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.65),
                        ],
                        stops: const [0.45, 1.0],
                      ),
                    ),
                  ),

                  // Title
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // subtle text shadow helps legibility on busy images
                        shadows: const [
                          Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 6,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
