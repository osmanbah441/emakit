import 'package:flutter/material.dart';
import 'package:product_list/src/components/offer_list_card.dart';
import 'package:product_repository/product_repository.dart';
import 'package:component_library/component_library.dart';

class ProductOffer {
  final String id;
  final String name;
  final String variant;
  final double price;
  final int stock;
  final OfferStatus status;
  final String imageUrl;
  final Color imageBgColor; // Fallback since we don't have real assets

  const ProductOffer({
    required this.id,
    required this.name,
    required this.variant,
    required this.price,
    required this.stock,
    required this.status,
    required this.imageUrl,
    required this.imageBgColor,
  });
}

// Mock Data
final List<ProductOffer> mockOffers = [
  const ProductOffer(
    id: '1',
    name: 'Classic Leather Watch',
    variant: 'Brown / 42mm',
    price: 149.99,
    stock: 50,
    status: OfferStatus.active,
    imageUrl:
        'https://images.unsplash.com/photo-1524592094714-0f0654e20314?auto=format&fit=crop&q=80&w=200',
    imageBgColor: Color(0xFFEFEBE0),
  ),
  const ProductOffer(
    id: '2',
    name: 'Trail Runner Shoes',
    variant: 'Red / US 10',
    price: 89.00,
    stock: 120,
    status: OfferStatus.paused,
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=200',
    imageBgColor: Color(0xFFF5F5F5),
  ),
  const ProductOffer(
    id: '3',
    name: 'Wireless Headphones',
    variant: 'Black',
    price: 99.00,
    stock: 0,
    status: OfferStatus.outOfStock,
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=200',
    imageBgColor: Color(0xFFFFE082),
  ),
  const ProductOffer(
    id: '4',
    name: 'Smart Speaker Mini',
    variant: 'Charcoal',
    price: 49.99,
    stock: 15,
    status: OfferStatus.active,
    imageUrl:
        'https://images.unsplash.com/photo-1589492477829-5e65395b66cc?auto=format&fit=crop&q=80&w=200',
    imageBgColor: Color(0xFFCFD8DC),
  ),
];

class ManageOffersScreen extends StatefulWidget {
  const ManageOffersScreen({
    super.key,
    required this.productRepository,
    required this.onAddOffer,
    required this.onOfferTapped,
  });

  final ProductRepository productRepository;
  final VoidCallback onAddOffer;
  final Function(String) onOfferTapped;

  @override
  State<ManageOffersScreen> createState() => _ManageOffersScreenState();
}

class _ManageOffersScreenState extends State<ManageOffersScreen> {
  String _selectedFilter = 'Active';
  final List<String> _filters = [
    'Active',
    'Paused',
    'Out of Stock',
    '+ Custom',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Offers')),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                hintText: 'Search offers...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: _filters.map((filter) {
                final bool isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(filter),
                    onSelected: (value) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    selected: isSelected,
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // Offer List
          Expanded(
            child: FutureBuilder(
              future: widget.productRepository.getStoreProductWithOffer(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const CenteredProgressIndicator();
                } else if (asyncSnapshot.hasError) {
                  return Center(child: Text('Error: ${asyncSnapshot.error}'));
                }

                final data = asyncSnapshot.data;
                if (data == null || data.isEmpty) {
                  return const Center(child: Text('No offers found.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(4.0),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final offer = data[index];
                    return OfferListCard(
                      offer: offer,
                      onTap: () => widget.onOfferTapped(offer.offerId!),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddOffer,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
