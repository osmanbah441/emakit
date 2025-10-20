import 'package:flutter/material.dart';

class ProductVariationListScreen extends StatelessWidget {
  const ProductVariationListScreen({
    super.key,
    required this.onAddVariation,
    required this.productId,
  });

  final String productId;
  final VoidCallback onAddVariation;

  @override
  Widget build(BuildContext context) {
    return ProductVariationListView(
      productId: productId,
      onAddVariation: onAddVariation,
    );
  }
}

class ProductVariationListView extends StatelessWidget {
  const ProductVariationListView({
    super.key,
    required this.productId,
    required this.onAddVariation,
  });

  final String productId;
  final VoidCallback onAddVariation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Variations'),
        actions: [
          ElevatedButton(
            onPressed: onAddVariation,
            child: const Text('Add Variation'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 1),
          () => ['Variation 1', 'Variation 2', 'Variation 3'],
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final variations = snapshot.data as List<String>;
            return ListView.builder(
              itemCount: variations.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(variations[index]));
              },
            );
          }
        },
      ),
    );
  }
}
