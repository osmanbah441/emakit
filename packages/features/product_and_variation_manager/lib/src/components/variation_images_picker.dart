import 'package:flutter/material.dart';

class VariationImagesPicker extends StatelessWidget {
  final List<String> imageUrls;
  final VoidCallback onAddImage;
  final ValueChanged<int> onRemoveImage;

  const VariationImagesPicker({
    super.key,
    required this.imageUrls,
    required this.onAddImage,
    required this.onRemoveImage,
  });

  static const double _cardHeight = 340.0;
  static const double _cardWidth = 280.0;
  static const int _maxImages = 5;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tileRadius = BorderRadius.circular(12);

    final int imageCount = imageUrls.length;
    final bool showAddButton = imageCount < _maxImages;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Variation Images',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Counter display
              Text(
                '$imageCount/$_maxImages',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Add up to $_maxImages images for this variation.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: _cardHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              // Total items = existing images + 1 slot for add button (if showing)
              itemCount: imageCount + (showAddButton ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                // If we are showing the add button, and this index maps to the last slot:
                if (showAddButton && index == imageCount) {
                  return GestureDetector(
                    onTap: onAddImage,
                    child: Container(
                      width: _cardWidth,
                      height: _cardHeight,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: tileRadius,
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              size: 36,
                              color: theme.iconTheme.color,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Add Image',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                // Otherwise, render the actual image at this index
                final imgUrl = imageUrls[index];
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: tileRadius,
                      child: Container(
                        width: _cardWidth,
                        height: _cardHeight,
                        color: theme.colorScheme.surface,
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.broken_image,
                            size: 36,
                            color: theme.iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: InkWell(
                        onTap: () => onRemoveImage(index),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
