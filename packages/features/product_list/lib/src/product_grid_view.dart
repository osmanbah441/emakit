import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_list_bloc.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  final List<Product> products;
  final Function(BuildContext, String) onProductTap;

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductListBloc>();

    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75, // Adjusted for better aspect ratio
      ),
      itemCount: products.length,
      itemBuilder: (context, indx) {
        final product = products[indx];

        return ProductCard(
          imageUrl: product.variations.first.imageUrls.first,
          title: product.name,
          price: product.variations.first.price,
          onTap: () => onProductTap(context, product.id!),
          onAddToCart: () {
            bloc.add(ToggleCartStatus(product.variations.first));
            _showSnackBar(context, 'Added "${product.name}" to cart!');
          },
          onWishlistToggle: () {
            bloc.add(ToggleWishlistStatus(product.id!));
            _showSnackBar(context, 'Added "${product.name}" to wishlist!');
          },
        );
      },
    );
  }
}
