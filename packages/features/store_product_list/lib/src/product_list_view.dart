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

  void _showDailog(BuildContext context, String imageUrl) async =>
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: AppNetworkImage(
              width: 300,
              height: 400,
              imageUrl: imageUrl,
              borderRadius: BorderRadius.circular(24),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return null;
        // final imageUrl = product.primaryImageUrl!;
        // return ListTile(
        //   onTap: () => onProductTap(context, product.id!),
        //   leading: SizedBox(
        //     width: 60,
        //     height: 60,
        //     child: InkWell(
        //       onTap: () => _showDailog(context, imageUrl),
        //       child: AppNetworkImage(
        //         borderRadius: BorderRadius.circular(12),
        //         imageUrl: imageUrl,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        //   title: Text(product.name),
        // );
      },
    );
  }
}
