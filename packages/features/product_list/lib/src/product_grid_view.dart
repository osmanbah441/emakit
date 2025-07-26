import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  final List<Product> products;
  final Function(BuildContext, String) onProductTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.70, // Adjusted for better aspect ratio
      ),
      itemCount: products.length,
      itemBuilder: (context, indx) {
        final product = products[indx];

        return ProductCard(
          imageUrl: product.variations.first.imageUrls.first,
          title: product.name,
          price: product.variations.first.price,
          onTap: () => onProductTap(context, product.id!),
        );
      },
    );
  }
}
