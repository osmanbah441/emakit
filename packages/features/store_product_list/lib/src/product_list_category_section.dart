import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
// for ProductCard

class ProductListCategorySection extends StatelessWidget {
  final String categoryTitle;
  final VoidCallback onSeeMore;
  final List<Product> products;
  final Function(Product) onProductTap;
  final Function(Product) onAddToCart;
  final Function(Product) onWishlistToggle;

  const ProductListCategorySection({
    super.key,
    required this.categoryTitle,
    required this.onSeeMore,
    required this.products,
    required this.onProductTap,
    required this.onAddToCart,
    required this.onWishlistToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with category title and "See more"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(onPressed: onSeeMore, child: const Text('See more')),
            ],
          ),
        ),

        // Horizontal product list
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              return Placeholder();
              // return SizedBox(
              //   width: 220, // fixed width to align cards
              //   child: ProductCard(
              //     imageUrl: product.variations.first.imageUrls.first,
              //     title: product.name,
              //     price: product.variations.first.price,
              //     onTap: () => onProductTap(product),
              //   ),
              // );
            },
          ),
        ),
      ],
    );
  }
}
