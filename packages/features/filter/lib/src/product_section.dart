import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_cubit.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  final List<Product> products;
  final Function(BuildContext context, String productId) onProductTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Column(
        spacing: 8,
        children: [
          BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
            builder: (context, state) {
              if (state is! CategoryDetailsLoaded) {
                return const SizedBox.shrink();
              }

              return HorizontalFilterSelector(
                itemLabelBuilder: (category) => category.name,

                options: state.subCategories,
                selectedOption: state.tempFilters.selectedSubCategory,
                onOptionSelected: (category) {
                  context.read<CategoryDetailsCubit>().filterBySubCategory(
                    category,
                  );
                },
              );
            },
          ),

          if (products.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Center(
                child: Text(
                  'No products found with the current filters.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 300 / 380,
              ),
              itemCount: products.length,
              itemBuilder: (context, indx) {
                final product = products[indx];

                return ProductCard(
                  imageUrl: product.variations.first.imageUrls.first,
                  title: product.name,
                  price: product.variations.first.price,
                  onTap: () => onProductTap(context, product.id!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
