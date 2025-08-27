import 'package:cached_network_image/cached_network_image.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ProductListCard extends StatelessWidget {
  final String imageUrl;
  final double? price;
  final bool isFavorite;
  final VoidCallback? onTap;

  const ProductListCard({
    super.key,
    required this.imageUrl,
    this.price,
    this.isFavorite = false,
    this.onTap,
  });

  static const _borderRadius = BorderRadius.all(Radius.circular(12));

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: _borderRadius),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: _borderRadius,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => CenteredProgressIndicator(),
                errorWidget: (context, error, stack) =>
                    const Center(child: Icon(Icons.broken_image, size: 40)),
              ),
            ),
            if (price != null)
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'NLE ${price!.toStringAsFixed(2)}',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
