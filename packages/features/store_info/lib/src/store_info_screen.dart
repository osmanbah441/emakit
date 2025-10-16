import 'package:flutter/material.dart';

// --- MODELS ---

class Product {
  final String name;
  final String imageUrl;
  final double price;

  Product({required this.name, required this.imageUrl, required this.price});
}

// --- MAIN SCREEN ---

class StoreInfoScreen extends StatefulWidget {
  const StoreInfoScreen({super.key});

  @override
  State<StoreInfoScreen> createState() => _StoreInfoScreenState();
}

class _StoreInfoScreenState extends State<StoreInfoScreen> {
  bool _isFollowed = false;

  // Dummy store meta
  final double _rating = 4.8;
  final int _reviews = 320;
  final int _followers = 1234;
  final int _productsCount = 150;
  final String _storeName = 'Kansas City Store';

  final List<Product> _products = List.generate(
    20,
    (index) => Product(
      name: 'Stylish Item ${index + 1}',
      imageUrl: 'https://picsum.photos/seed/fashion${index + 1}/600/600',
      price: double.parse(((19.99 * (index + 1)) % 150).toStringAsFixed(2)),
    ),
  );

  void _toggleFollow() {
    setState(() => _isFollowed = !_isFollowed);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFollowed
              ? 'You are now following this store!'
              : 'You have unfollowed this store.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static String _formatCount(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildStoreHeader(),
          _buildStoreInfoAndActions(context),
          _buildProductHeader(),
          _buildProductGrid(),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS (Consolidated Logic) ---

  Widget _buildProductCard(Product product) {
    final priceStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2.5,
      shadowColor: Colors.black.withOpacity(0.12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, prog) {
                if (prog == null) return child;
                final value = prog.expectedTotalBytes != null
                    ? prog.cumulativeBytesLoaded / prog.expectedTotalBytes!
                    : null;
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: value,
                  ),
                );
              },
              errorBuilder: (context, error, stack) => const Center(
                child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: priceStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildStoreHeader() => SliverAppBar(
    expandedHeight: 200,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 12),
      title: const Text(
        'Kansas City Store',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      background: Image.network(
        'https://picsum.photos/seed/storebanner/1200/600',
        fit: BoxFit.cover,
      ),
    ),
  );

  Widget _buildProductHeader() => const SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        'All Products',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
  );

  Widget _buildProductGrid() => SliverPadding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    sliver: SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildProductCard(_products[index]),
        childCount: _products.length,
      ),
    ),
  );

  Widget _buildStoreInfoAndActions(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final primaryColor = Theme.of(context).primaryColor;

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Logo + Name + Actions
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/seed/storelogo/100',
                  ),
                ),
                const SizedBox(width: 14),

                // Name, Rating, Stats
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              _storeName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(Icons.verified, size: 18, color: scheme.primary),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Rating
                      Row(
                        children: [
                          _StarRating(rating: _rating, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            '$_rating (${_formatCount(_reviews)} reviews)',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // Followers / Products
                      Row(
                        children: [
                          const Icon(
                            Icons.group,
                            size: 16,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${_formatCount(_followers)} Followers',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.inventory_2,
                            size: 16,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$_productsCount Products',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action buttons
                IconButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share button tapped!')),
                  ),
                  icon: const Icon(Icons.share_outlined, color: Colors.black87),
                  tooltip: 'Share',
                ),
                IconButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('WhatsApp button tapped!')),
                  ),
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: Color(0xFF25D366),
                  ),
                  tooltip: 'WhatsApp',
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Row 2: Follow (full width)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _toggleFollow,
                icon: Icon(_isFollowed ? Icons.check : Icons.add, size: 18),
                label: Text(_isFollowed ? 'Following' : 'Follow'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _isFollowed ? Colors.white : primaryColor,
                  backgroundColor: _isFollowed
                      ? primaryColor
                      : Colors.transparent,
                  side: BorderSide(color: primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- HELPER WIDGET (Kept for complex reusable logic) ---

class _StarRating extends StatelessWidget {
  final double rating;
  final double size;

  const _StarRating({required this.rating, this.size = 16});

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final fractional = rating - fullStars;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        IconData icon;
        if (i < fullStars) {
          icon = Icons.star;
        } else if (i == fullStars && fractional >= 0.25) {
          // Use star_half for 0.25 to 0.74, and star for 0.75+
          icon = fractional < 0.75 ? Icons.star_half : Icons.star;
        } else {
          icon = Icons.star_border;
        }
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(icon, size: size, color: Colors.amber),
        );
      }),
    );
  }
}
