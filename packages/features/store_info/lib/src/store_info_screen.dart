import 'package:flutter/material.dart';

class Product {
  final String name;
  final String imageUrl;
  final double price;

  Product({required this.name, required this.imageUrl, required this.price});
}

// --- SCREENS ---

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          StoreHeader(title: 'Kansas City Store'),

          StoreInfoAndActions(
            isFollowed: _isFollowed,
            onFollowPressed: _toggleFollow,
            storeName: 'Kansas City Store',
            rating: _rating,
            reviews: _reviews,
            followers: _followers,
            productsCount: _productsCount,
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Text(
                'All Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductCard(product: _products[index]),
                childCount: _products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGETS ---

class StoreHeader extends StatelessWidget {
  final String title;
  const StoreHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 12),
        title: const _CollapsingTitle(),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://picsum.photos/seed/storebanner/1200/600',
              fit: BoxFit.cover,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Colors.black45, Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollapsingTitle extends StatelessWidget {
  const _CollapsingTitle();

  @override
  Widget build(BuildContext context) {
    // Keep the title minimal when collapsed; banner already shows visual identity.
    return const Text(
      'Kansas City Store',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    );
  }
}

class StoreInfoAndActions extends StatelessWidget {
  final bool isFollowed;
  final VoidCallback onFollowPressed;

  final String storeName;
  final double rating;
  final int reviews;
  final int followers;
  final int productsCount;

  const StoreInfoAndActions({
    super.key,
    required this.isFollowed,
    required this.onFollowPressed,
    required this.storeName,
    required this.rating,
    required this.reviews,
    required this.followers,
    required this.productsCount,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

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
                // Store Logo
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
                              storeName,
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
                          StarRating(rating: rating, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            '$rating (${_formatCount(reviews)} reviews)',
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
                            '${_formatCount(followers)} Followers',
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
                            '$productsCount Products',
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
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Share button tapped!')),
                    );
                  },
                  icon: const Icon(Icons.share_outlined, color: Colors.black87),
                  tooltip: 'Share',
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('WhatsApp button tapped!')),
                    );
                  },
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
                onPressed: onFollowPressed,
                icon: Icon(isFollowed ? Icons.check : Icons.add, size: 18),
                label: Text(isFollowed ? 'Following' : 'Follow'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isFollowed
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  backgroundColor: isFollowed
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  side: BorderSide(color: Theme.of(context).primaryColor),
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

  static String _formatCount(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}

class StarRating extends StatelessWidget {
  final double rating; // e.g., 4.8
  final double size;

  const StarRating({super.key, required this.rating, this.size = 16});

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalf = (rating - fullStars) >= 0.25 && (rating - fullStars) < 0.75;
    final showFullForHalfUp = (rating - fullStars) >= 0.75;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        IconData icon;
        if (i < fullStars) {
          icon = Icons.star;
        } else if (i == fullStars && !showFullForHalfUp && hasHalf) {
          icon = Icons.star_half;
        } else if (i == fullStars && showFullForHalfUp) {
          icon = Icons.star;
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

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
          // Image
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, prog) {
                if (prog == null) return child;
                final expected = prog.expectedTotalBytes;
                final loaded = prog.cumulativeBytesLoaded;
                final value = expected != null ? loaded / expected : null;
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

          // Details
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
}
