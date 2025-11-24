import 'package:flutter/material.dart';
import 'package:product_add_or_edit/src/components/product_overview_card.dart';

// --- 1. Data Model for Product ---
class Product {
  final String name;
  final String manufacturer;
  final String imageUrlSeed;
  final Map<String, String> specs;

  Product({
    required this.name,
    required this.manufacturer,
    required this.imageUrlSeed,
    required this.specs,
  });
}

// --- 2. Custom AppBar: ImageSearchAppBar ---
class ImageSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackButtonPressed;
  final VoidCallback? onSearchWithImagePressed;
  final VoidCallback? onSearchPressed;

  const ImageSearchAppBar({
    super.key,
    this.onBackButtonPressed,
    this.onSearchWithImagePressed,
    this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBackButtonPressed ?? () => Navigator.pop(context),
      ),
      title: OutlinedButton.icon(
        onPressed: onBackButtonPressed,
        label: Text('Search with Image'),
        icon: const Icon(Icons.camera_alt_outlined, size: 16),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// --- 4. Main Product Matcher Screen: ProductMatcherScreen (with FAB) ---
class ProductMatcherScreen extends StatelessWidget {
  const ProductMatcherScreen({super.key});

  static final List<Product> _products = [
    Product(
      manufacturer: 'SonixGear',
      name: 'Acoustic Pro Headphones',
      imageUrlSeed: 'headphones_black',
      specs: {'Model': 'TX-990', 'Color': 'Midnight Black', 'Storage': '256GB'},
    ),
    Product(
      manufacturer: 'SoundWave',
      name: 'On-Ear Headphones',
      imageUrlSeed: 'headphones_white',
      specs: {
        'Model': 'SW-202',
        'Color': 'Pure White',
        'Connectivity': 'Bluetooth 5.2',
      },
    ),
    Product(
      manufacturer: 'VividSound',
      name: 'Aura Studio Headphones',
      imageUrlSeed: 'headphones_rose_gold',
      specs: {
        'Model': 'AS-V2',
        'Color': 'Rose Gold',
        'Driver Size': '50mm Dynamic',
        'Feature': 'Passive Mode',
      },
    ),
  ];

  void _handleCreateNewProduct() {
    print('FAB: Create New Product tapped!');
  }

  void _handleImageSearch() {
    print('Image Search button tapped!');
  }

  void _handleStandardSearch() {
    print('Standard Search button tapped!');
  }

  // NEW: Handler for when a product card is tapped
  void _handleProductTap(Product product) {
    print('Product Tapped: ${product.name} (${product.manufacturer})');
    // Here you would typically navigate to a product detail screen:
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: ImageSearchAppBar(
        onBackButtonPressed: () {
          print('Back button pressed!');
        },
        onSearchWithImagePressed: _handleImageSearch,
        onSearchPressed: _handleStandardSearch,
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];

          return ProductOverviewCard(
            manufacturer: product.manufacturer,
            productName: product.name,
            imageUrls: List.generate(
              3,
              (index) =>
                  'https://picsum.photos/seed/${product.imageUrlSeed}$index/600/600',
            ),
            specs: product.specs,
            // Pass the tap handler, referencing the specific product
            onTap: () => _handleProductTap(product),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleCreateNewProduct,
        label: const Text(
          'Create New Product',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
