import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class OfferComparisonModal extends StatelessWidget {
  final List<StoreOffer> offers;
  final Function(StoreOffer) onAddToCart;
  final Function(StoreOffer) onVisitStore;

  const OfferComparisonModal({
    super.key,
    required this.offers,
    required this.onAddToCart,
    required this.onVisitStore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // Sort by price, then stock
    final sortedOffers = [...offers]
      ..sort((a, b) {
        final priceComparison = a.price.compareTo(b.price);
        return priceComparison != 0
            ? priceComparison
            : b.stockQuantity.compareTo(a.stockQuantity);
      });

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Material(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Compare Offers',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  itemCount: sortedOffers.length,
                  itemBuilder: (context, index) {
                    final offer = sortedOffers[index];
                    final isBest = index == 0 && offer.stockQuantity > 0;
                    final isAvailable = offer.stockQuantity > 0;
                    final storeImageUrl =
                        'https://picsum.photos/seed/${offer.storeId.hashCode}/120/120';

                    return Card(
                      elevation: isBest ? 3 : 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    storeImageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (isBest)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'Best',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer.storeName,
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '\$${offer.price.toStringAsFixed(2)}',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    isAvailable
                                        ? 'In Stock: ${offer.stockQuantity}'
                                        : 'Out of Stock',
                                    style: textTheme.labelSmall?.copyWith(
                                      color: isAvailable
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    spacing: 4,
                                    children: [
                                      TextButton(
                                        onPressed: () => onVisitStore(offer),
                                        child: const Text('Visit Store'),
                                      ),
                                      ElevatedButton(
                                        onPressed: isAvailable
                                            ? () => onAddToCart(offer)
                                            : null,

                                        child: const Text('Add to Cart'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
