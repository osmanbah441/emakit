import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onProductTap});

  final Function(BuildContext context, String productId) onProductTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Easy'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.help_outline))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            AppSearchBar(
              onSearchchanged: (term) {
                print(term);
              },
            ),
            Expanded(
              child: GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 300 / 380,
                children: List.generate(
                  20,
                  (indx) => ProductCard(
                    imageUrl: 'https://picsum.photos/200/300?random=$indx',
                    title: 'product $indx',
                    price: 10.0 * indx,
                    onTap: () => onProductTap(context, 'product $indx'),
                    onAddToCart: () {},
                    onWishlistToggle: () {},
                    isInCart: false,
                    isWishlisted: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
