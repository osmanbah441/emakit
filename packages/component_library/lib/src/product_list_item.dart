import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final String?
  subtitle; // Optional subtitle (e.g., stock, quantity, description snippet)
  final VoidCallback? onTap;
  final String? heroTag; // Optional hero tag for the image
  final List<Widget>?
  trailingActions; // The key to reusability: a list of widgets for actions
  final double imageWidth; // NEW: Make image width configurable
  final double imageHeight; // NEW: Make image height configurable

  const ProductListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.subtitle,
    this.onTap,
    this.heroTag,
    this.trailingActions,
    this.imageWidth = 80.0, // Default width for list item image
    this.imageHeight = 80.0, // Default height for list item image
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: ImageDisplay(
                  imageUrl: imageUrl,
                  heroTag: heroTag, // Pass the hero tag
                  aspectRatio: 2.0, // Make it square for list item
                  borderRadius: BorderRadius.circular(8),
                  errorWidget: SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(
                      child: Icon(Icons.image_not_supported_outlined, size: 30),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Product Details (Title, Price, Subtitle)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    PriceDisplayText(price: price),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Action Buttons (Dynamic)
              if (trailingActions != null && trailingActions!.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: trailingActions!, // Render the provided actions
                ),
            ],
          ),
        ),
      ),
    );
  }
}
