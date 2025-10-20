import 'dart:math' as math;
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/src/custom_sliver_staggered_grid.dart';
import 'package:domain_models/domain_models.dart';
import 'product_list_cubit.dart';

class BuyerProductListScreen extends StatelessWidget {
  final Function(String productId) onProductSelected;
  final String parentCategoryId;

  const BuyerProductListScreen({
    super.key,
    required this.onProductSelected,
    required this.parentCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListCubit(parentCategoryId: parentCategoryId),
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
      body: SafeArea(
        child: BlocBuilder<ProductListCubit, ProductListState>(
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
                    expandedHeight: 200.0,
                    floating: true,
                    pinned: true, // This keeps the collapsed app bar visible
                    snap: true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 1.0,
                    title: Text(state.topLevelCategory?.name ?? ''),
                    flexibleSpace: FlexibleSpaceBar(
                      background: CircularImageSelector<Category>(
                        items: state.categories,
                        selectedLabel: state.selectedSubCategory?.name,
                        onItemChanged: cubit.selectCategory,
                        labelBuilder: (category) => category.name,
                        imageBuilder: (category) => category.imageUrl,
                      ),
                    ),
                  ),
                  _buildProductGrid(2, state.allProducts),
                ],
              );
            }
            return const Center(child: Text("Something went wrong."));
          },
        ),
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
            imageUrl: ' product.primaryImageUrl!',
            price: 0.00,
            onTap: () => onProductTap(product.id),
          );
        }),
      ),
    );
  }
}
