import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class StoreProductListCard extends StatelessWidget {
  final VoidCallback onTap;
  final Product product;

  const StoreProductListCard({
    super.key,
    required this.onTap,
    required this.product,
  });

  Color _getStatusColor(ColorScheme colorScheme, ProductStatus status) {
    switch (status) {
      case ProductStatus.active:
        return colorScheme.primary;
      case ProductStatus.draft:
        return colorScheme.tertiary;
      case ProductStatus.archived:
        return colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final imageUrl = product.mainProductMedia.isNotEmpty
        ? product.mainProductMedia.first.url
        : 'https://via.placeholder.com/150';

    final statusColor = _getStatusColor(colorScheme, product.status);
    final statusLabel =
        product.status.name.substring(0, 1).toUpperCase() +
        product.status.name.substring(1);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 6, color: statusColor),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppNetworkImage(
                  imageUrl: imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.circle, size: 8, color: statusColor),
                          const SizedBox(width: 6),
                          Text(
                            statusLabel,
                            style: theme.textTheme.labelMedium!.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Center(
                  child: Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
