// product_list_screen.dart

import 'dart:math' as math;
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/src/custom_sliver_staggered_grid.dart';
import 'package:product_list/src/filter_header_component.dart';
import 'package:domain_models/domain_models.dart';
import 'product_list_cubit.dart';

class ProductListScreen extends StatelessWidget {
  final Function(String productId) onProductSelected;
  final String parentCategoryId;

  const ProductListScreen({
    super.key,
    required this.onProductSelected,
    required this.parentCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListCubit(parentCategoryId),
      child: _ProductListContent(onProductTap: onProductSelected),
    );
  }
}

class _ProductListContent extends StatelessWidget {
  final Function(String productId) onProductTap;

  const _ProductListContent({required this.onProductTap});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductListCubit>();
    return Scaffold(
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          if (state is ProductInitial || state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          if (state is ProductLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: FilterHeaderComponent(
                    title: state.topLevelCategory?.name ?? '',
                    onCategoryChanged: (category) =>
                        cubit.selectCategory(category),
                    categories: state.categories,
                    activeCategory: state.selectedSubCategory,
                  ),
                  toolbarHeight: 200,
                  elevation: 1.0,
                ),
                _buildProductGrid(2, state.allProducts),
              ],
            );
          }
          return const Center(child: Text("Something went wrong."));
        },
      ),
    );
  }

  Widget _buildProductGrid(int crossAxisCount, List<Product> products) {
    if (products.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: Text("No products match your criteria.")),
      );
    }

    final childAspectRatios = products
        .map((p) => 400 / (math.Random(p.id.hashCode).nextInt(300) + 400))
        .toList();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: CustomSliverStaggeredGrid(
        crossAxisCount: crossAxisCount,
        childAspectRatios: childAspectRatios,
        children: List.generate(products.length, (index) {
          final product = products[index];
          return ProductListCard(
            imageUrl: product.images.first,
            price: product.basePrice,
            onTap: () => onProductTap(product.id),
          );
        }),
      ),
    );
  }
}
