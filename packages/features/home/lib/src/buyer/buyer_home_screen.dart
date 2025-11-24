import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/buyer/buyer_home_cubit.dart';
import 'package:home/src/buyer/buyer_home_state.dart';
import 'package:home/src/components/parent_category_section.dart';
import 'package:home/src/components/featured_store_item.dart';
import 'package:store_repository/store_repository.dart';

class BuyerHomeScreen extends StatelessWidget {
  const BuyerHomeScreen({
    super.key,
    required this.onCategoryTap,
    required this.categoryRepository,
    required this.storeRepository,
    required this.onStoreTap,
  });

  final Function(String id) onCategoryTap;
  final CategoryRepository categoryRepository;
  final StoreRepository storeRepository;
  final VoidCallback onStoreTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuyerHomeCubit(
        categoryRepository: categoryRepository,
        storeRepository: storeRepository,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Salone Bazaar'),
          centerTitle: false,
          actions: [
            IconButton(onPressed: onStoreTap, icon: const Icon(Icons.store)),
          ],
        ),
        body: BlocBuilder<BuyerHomeCubit, BuyerHomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text(state.error!));
            }

            final parentNames = state.parentCategories.keys.toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                    child: Text(
                      'Shop Smart, Shop Simple.',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    child: Text(
                      'Discover vetted, quality goods delivered directly to you. It\'s shopping made easy.', // Explaining the Trust and Convenience
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  // Dynamic Category Sections
                  ...parentNames.map((name) {
                    final categories = state.parentCategories[name]!;
                    return ParentCategorySection(
                      onSubcategoryTap: onCategoryTap,
                      parentName: name,
                      subCategories: categories,
                    );
                  }),

                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Featured Stores',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'See More',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.featuredStores.length,
                      itemBuilder: (context, index) =>
                          FeaturedStoreItem(store: state.featuredStores[index]),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
