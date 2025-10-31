import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:cart_repository/cart_repository.dart';
import '../components/components.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_details/src/buyer/buyer_product_details_cubit.dart';

class BuyerProductDetailsScreen extends StatelessWidget {
  const BuyerProductDetailsScreen({
    super.key,
    required this.productRepository,
    required this.cartRepository,
    required this.userRepository,
    required this.variantId,
    required this.onVisitStoreTap,
  });

  final ProductRepository productRepository;
  final CartRepository cartRepository;
  final UserRepository userRepository;
  final String variantId;
  final Function(String) onVisitStoreTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BuyerProductDetailsCubit(
        productRepository: productRepository,
        cartRepository: cartRepository,
        userRepository: userRepository,
        variantId: variantId,
      ),
      child: const _ProductDetailView(),
    );
  }
}

class _ProductDetailView extends StatelessWidget {
  const _ProductDetailView();

  void _showOfferModal(BuildContext context, List<StoreOffer> offers) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => OfferComparisonModal(
        offers: offers,
        onAddToCart: (offer) {
          context.read<BuyerProductDetailsCubit>().addToCart(offer.id);
          Navigator.pop(context);
        },
        onVisitStore: (offer) {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<BuyerProductDetailsCubit, BuyerProductDetailsState>(
      builder: (context, state) {
        if (state is BuyerProductDetailsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is BuyerProductDetailsError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        if (state is BuyerProductDetailsLoaded) {
          final product = state.product;
          final variant = state.selectedVariant;
          final offers = variant?.offers ?? [];
          final bestOffer = offers.isNotEmpty
              ? (offers..sort((a, b) => a.price.compareTo(b.price))).first
              : null;

          return Scaffold(
            appBar: AppBar(),
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProductInfoSection(
                      name: product.name,
                      storeName: bestOffer?.storeName ?? '',
                      onStoreTap: () => {},
                      reviewCount: product.reviewCount,
                      averageRating: product.averageRating,
                    ),
                  ),

                  // product images
                  if (variant != null)
                    ProductImageCarousel(
                      imageUrls: variant.media.map((m) => m.url).toList(),
                    ),

                  // unified variation selector
                  ProductVariationSelector(
                    variants: product.variants,
                    selectedVariant: variant,
                    onVariantSelected: (v) {
                      context.read<BuyerProductDetailsCubit>().selectVariant(v);
                    },
                  ),

                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // price and offer comparison
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Best Price', style: textTheme.labelSmall),
                                Text(
                                  bestOffer != null
                                      ? 'NLE ${bestOffer.price.toStringAsFixed(2)}'
                                      : 'N/A',
                                  style: textTheme.headlineSmall,
                                ),
                              ],
                            ),
                            if (offers.length > 1)
                              TextButton.icon(
                                onPressed: () =>
                                    _showOfferModal(context, offers),
                                icon: const Icon(Icons.storefront),
                                label: Text(
                                  'Compare ${offers.length} offers',
                                  style: textTheme.labelMedium?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // add to cart
                        PrimaryActionButton(
                          icon: const Icon(Icons.shopping_bag_outlined),
                          onPressed: bestOffer != null
                              ? () {
                                  context
                                      .read<BuyerProductDetailsCubit>()
                                      .addToCart(bestOffer.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Added ${variant?.variantSignature} from ${bestOffer.storeName} to cart!',
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          label: bestOffer != null
                              ? 'Add to Cart'
                              : 'Out of Stock',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SpecificationSection(
                      description: product.description,
                      specifications: product.specifications,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
