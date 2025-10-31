import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';

import 'product_list_cubit.dart';
import 'components/components.dart';

class BuyerProductListScreen extends StatelessWidget {
  const BuyerProductListScreen({
    super.key,
    required this.parentCategoryId,
    required this.onProductTap,
    required this.productRepository,
  });
  final Function(String productId, String variantId) onProductTap;
  final ProductRepository productRepository;
  final String parentCategoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListCubit(
        ApplicationRole.buyer,
        parentCategoryId: parentCategoryId,
        productRepository: productRepository,
      ),
      child: _BuyerProductListScreenContent(onProductTap: onProductTap),
    );
  }
}

class _BuyerProductListScreenContent extends StatelessWidget {
  const _BuyerProductListScreenContent({required this.onProductTap});
  final Function(String productId, String variantId) onProductTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products'), centerTitle: false, elevation: 0),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          if (state is ProductLoading || state is ProductInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          if (state is ProductLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.categories.isNotEmpty) ...[
                  CircularImageSelector(
                    height: 130,
                    items: state.categories,
                    onItemChanged: (category) {
                      context.read<ProductListCubit>().selectCategory(category);
                    },
                    // This is now safe as selectedSubCategory is guaranteed non-null
                    selectedLabel: state.selectedSubCategory!.name,
                    selectedItemId: state.selectedSubCategory!.id,
                    labelBuilder: (category) => category.name,
                    imageBuilder: (category) => category.imageUrl,
                  ),

                  if (state.isProductLoading) const LinearProgressIndicator(),
                ],
                Expanded(
                  child: state.isProductLoading
                      ? const Center(child: Text('Filtering products...'))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: state.allProducts.length,
                          itemBuilder: (context, index) {
                            return BuyerProductListCard(
                              product:
                                  state.allProducts[index] as BuyerProductsList,
                              onProductTap: onProductTap,
                            );
                          },
                        ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
