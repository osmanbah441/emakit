import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/home_cubit.dart';

import 'package:product_repository/product_repository.dart';
import 'package:component_library/component_library.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onSeeAllStoreTap,
    required this.onCategoryCardTap,
    this.onStoreCardTap,
    this.onTrendingTap,
    this.onNewArrivalsTap,
    this.onFeaturedProductTap,
    this.onDealsTap,
  });

  final VoidCallback onSeeAllStoreTap;
  final Function(String id) onCategoryCardTap;
  final Function(String id)? onStoreCardTap;
  final VoidCallback? onTrendingTap;
  final VoidCallback? onNewArrivalsTap;
  final VoidCallback? onFeaturedProductTap;
  final VoidCallback? onDealsTap;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ProductRepository>(
      create: (_) => ProductRepository.instance,
      child: BlocProvider(
        create: (_) => HomeCubit(),
        child: HomeView(
          onDiscoverStoreTap: onSeeAllStoreTap,
          onCategoryCardTap: onCategoryCardTap,
          onStoreCardTap: onStoreCardTap,
          onTrendingTap: onTrendingTap,
          onNewArrivalsTap: onNewArrivalsTap,
          onFeaturedProductTap: onFeaturedProductTap,
          onDealsTap: onDealsTap,
        ),
      ),
    );
  }
}

@visibleForTesting
class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    this.onStoreCardTap,
    required this.onDiscoverStoreTap,
    required this.onCategoryCardTap,
    this.onTrendingTap,
    this.onNewArrivalsTap,
    this.onFeaturedProductTap,
    this.onDealsTap,
  });

  final VoidCallback onDiscoverStoreTap;
  final Function(String id) onCategoryCardTap;
  final Function(String id)? onStoreCardTap;
  final VoidCallback? onTrendingTap;
  final VoidCallback? onNewArrivalsTap;
  final VoidCallback? onFeaturedProductTap;
  final VoidCallback? onDealsTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salone Bazaar'), centerTitle: false),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == HomeStatus.failure) {
            return ExceptionIndicator(
              message: state.errorMessage,
              onButtonTapped: () =>
                  context.read<HomeCubit>().fetchHomePageData(),
            );
          }
          if (state.status == HomeStatus.success) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                child: Column(
                  spacing: 40,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 300,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        // padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        children: [
                          PromoBannerCard(
                            onTap: onTrendingTap,
                            title: "Trending",
                            imageUrl: "https://picsum.photos/id/103/800/600",
                          ),
                          SizedBox(width: 16),
                          PromoBannerCard(
                            onTap: onFeaturedProductTap,
                            title: "Featured products",
                            imageUrl: "https://picsum.photos/id/2032/800/600",
                          ),
                          SizedBox(width: 16),
                          PromoBannerCard(
                            onTap: onDealsTap,
                            title: "Top Deals",
                            imageUrl: "https://picsum.photos/id/1015/800/600",
                          ),
                          SizedBox(width: 16),
                          PromoBannerCard(
                            onTap: onNewArrivalsTap,
                            title: "New Arrivals",
                            imageUrl: "https://picsum.photos/id/1025/800/600",
                          ),
                        ],
                      ),
                    ),

                    /// Categories
                    FeaturedGridSection(
                      title: 'Clothing',
                      items: state.productCategories,
                      itemBuilder: (context, item) => CategoryCard(
                        imageUrl: item.imageUrl,
                        name: item.name,
                      ),
                      onItemTap: (item) => onCategoryCardTap(item.id!),
                    ),

                    /// Featured Stores
                    FeaturedListSection(
                      items: state.featuredStores,
                      onSeeAllTap: onDiscoverStoreTap,
                      title: 'Featured Stores',
                      itemBuilder: (context, item) => StoreCard(
                        name: item.name,
                        rating: item.rating,
                        // : item.reviewCount,
                        onFollowTap: () =>
                            context.read<HomeCubit>().toggleFollow(item.id),
                        followers: item.reviewCount,
                        isFollowed: item.isVerified,
                        imageUrl:
                            item.logoUrl ?? 'https://picsum.photo/200/300',
                        onTap: onStoreCardTap != null
                            ? () => onStoreCardTap!(item.id)
                            : null,
                      ),
                      itemLimit: 3,
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
