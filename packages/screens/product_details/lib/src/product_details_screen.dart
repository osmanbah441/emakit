import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

/// Displays the product name, price, and seller information.
class ProductInfoHeader extends StatelessWidget {
  final String productName;
  final String price;
  final String sellerInfo; // e.g., "Sold by: Knit Haven"

  const ProductInfoHeader({
    Key? key,
    required this.productName,
    required this.price,
    required this.sellerInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '$price | $sellerInfo',
            style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}

/// Displays the "About Product" description text.
class ProductDescription extends StatelessWidget {
  final String description;

  const ProductDescription({Key? key, required this.description})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Product',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 14.0,
              height: 1.5,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

/// Displays product specifications in a key-value format.
class ProductSpecifications extends StatelessWidget {
  final Map<String, String> specifications;

  const ProductSpecifications({Key? key, required this.specifications})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Specifications',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12.0),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(
                1.0,
              ), // Key column takes 1 part of available space
              1: FlexColumnWidth(2.0), // Value column takes 2 parts
            },
            children: specifications.entries.map((entry) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      entry.key,
                      style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Contains the "Add to Cart" and "Add to Favorites" buttons.
class ProductActionButtons extends StatelessWidget {
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorites;

  const ProductActionButtons({
    Key? key,
    required this.onAddToCart,
    required this.onAddToFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: PrimaryActionButton(
              onPressed: () {
                print('Add to Cart tapped!');
              },
              label: 'Add to Cart',
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: SecondaryActionButton(
              onAddToFavorites: onAddToFavorites,
              label: 'Add to Favorites',
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // Dummy Data for Product Details
  String _selectedSize = 'M';
  Color _selectedColor = Colors.black;

  final List<String> _availableSizes = ['S', 'M', 'L'];
  final List<Color> _availableColors = [
    Colors.black,
    Colors.grey.shade400,
    Colors.white,
  ];

  final Map<String, String> _productSpecifications = {
    'Material': 'Wool & Silk Blend',
    'Care': 'Machine Wash Cold',
    'Origin': 'Imported',
    'Regular Fit': 'True to size',
  };

  final List<Map<String, String>> _similarProducts = [
    {
      'imageUrl': 'https://picsum.photos/id/60/200/200',
      'title': 'Sweater 1',
      'price': '\$39.99',
    },
    {
      'imageUrl': 'https://picsum.photos/id/61/200/200',
      'title': 'Sweater 2',
      'price': '\$39.99',
    },
    {
      'imageUrl': 'https://picsum.photos/id/62/200/200',
      'title': 'Sweater 3',
      'price': '\$39.99',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductInfoHeader(
                    productName: 'Cozy Knit Sweater',
                    price: '\$49.99',
                    sellerInfo: 'Sold by: Knit Haven',
                  ),

                  ProductCarouselView(
                    imageUrls: [
                      'https://picsum.photos/id/1080/400/300',
                      'https://picsum.photos/id/1081/400/300',
                      'https://picsum.photos/id/1082/400/300',
                    ],
                  ),
                  SizeSelector(
                    sizes: _availableSizes,
                    selectedSize: _selectedSize,
                    onSizeSelected: (size) {
                      setState(() {
                        _selectedSize = size;
                        print('Selected size: $_selectedSize');
                      });
                    },
                  ),
                  ColorSelector(
                    colors: _availableColors,
                    selectedColor: _selectedColor,
                    onColorSelected: (color) {
                      setState(() {
                        _selectedColor = color;
                        print('Selected color: $_selectedColor');
                      });
                    },
                  ),

                  ProductDescription(
                    description:
                        'Stay warm and stylish with our Cozy Knit Sweater. Made from a soft blend of wool and cashmere, this sweater is perfect for chilly days. Available in multiple colors and sizes.',
                  ),
                  ProductActionButtons(
                    onAddToCart: () {
                      print('Add to Cart tapped!');
                      print(
                        'Selected Size: $_selectedSize, Selected Color: $_selectedColor',
                      );
                    },
                    onAddToFavorites: () {
                      print('Add to Favorites tapped!');
                    },
                  ),

                  ProductSpecifications(specifications: _productSpecifications),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                    child: Text(
                      'Recomended For You',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 220, // Height for horizontal list
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: _similarProducts.length,
                      itemBuilder: (context, index) {
                        final product = _similarProducts[index];

                        return SizedBox(
                          height: 256,
                          width: 192 - 32 - 8,

                          child: ProductCard(
                            imageUrl: product['imageUrl']!,
                            title: product['title']!,
                            price: 10,
                            onTap: () => print(
                              'Tapped similar product: ${product['title']}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
