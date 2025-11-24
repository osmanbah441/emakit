import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class ProductOverviewCard extends StatelessWidget {
  final String productName;
  final String manufacturer;
  final List<String> imageUrls;
  final Map<String, String> specs;
  final VoidCallback onTap;

  const ProductOverviewCard({
    super.key,
    required this.productName,
    required this.manufacturer,
    required this.imageUrls,
    required this.specs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.0);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(manufacturer, style: textTheme.labelLarge),
              const SizedBox(height: 4),
              Text(
                productName,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),

              ProductImageCarousel(
                imageUrls: imageUrls,
                aspectRatio: 16 / 9,
                borderRadius: borderRadius,
              ),
              const SizedBox(height: 16),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: specs.entries.map((entry) {
                  return _buildTableRow('${entry.key}:', entry.value);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            label,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
