import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  final List<Product> products;
  final Function(BuildContext, String) onProductTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductListItem(
          imageUrl: product.imageUrl ?? "https://picsum.photos/200/300",
          title: product.name,
          // subtitle: product.description,
          onTap: () {},
        );
      },
    );
  }
}
