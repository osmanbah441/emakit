import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ProductInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> imageUrls;
  final Map<String, dynamic> specs;
  final VoidCallback? onTap;
  final VoidCallback? onCreateNewVariation;
  final String variantSignature;
  final double aspectRatio;
  final double elevation;
  const ProductInfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrls,
    required this.variantSignature,
    required this.specs,
    this.onTap,
    this.onCreateNewVariation,
    this.aspectRatio = 16 / 9,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.0);
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: .start,
            children: <Widget>[
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(subtitle, style: textTheme.labelLarge),
                  if (onCreateNewVariation != null)
                    TextButton(
                      onPressed: onCreateNewVariation,
                      child: Text('Create a new variation'),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              ProductImageCarousel(
                enableFullScreen: false,
                isScrollable: true,
                imageUrls: imageUrls,
                aspectRatio: aspectRatio,
                borderRadius: borderRadius,
              ),
              const SizedBox(height: 16),
              Text(
                variantSignature,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: specs.entries
                    .map(
                      (entry) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              entry.key,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              entry.value,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
