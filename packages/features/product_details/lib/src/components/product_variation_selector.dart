import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_details/src/product_details_cubit.dart';

class ProductVariationSelector extends StatelessWidget {
  const ProductVariationSelector({super.key});

  List<ProductVariation> _sortVariations(
    List<ProductVariation> variations,
    String attributeKey,
  ) {
    final sortedList = List<ProductVariation>.from(variations);

    sortedList.sort((a, b) {
      final valueA = a.attributes[attributeKey];
      final valueB = b.attributes[attributeKey];

      if (attributeKey == 'size') {
        const sizeOrder = {
          'XS': 0,
          'S': 1,
          'M': 2,
          'L': 3,
          'XL': 4,
          'XXL': 5,
          'XXXL': 6,
        };
        final orderA = sizeOrder[valueA] ?? 99;
        final orderB = sizeOrder[valueB] ?? 99;
        if (orderA != 99 || orderB != 99) {
          return orderA.compareTo(orderB);
        }
      }

      final numA = double.tryParse(valueA ?? '');
      final numB = double.tryParse(valueB ?? '');
      if (numA != null && numB != null) {
        return numA.compareTo(numB);
      }

      return (valueA ?? '').compareTo(valueB ?? '');
    });

    return sortedList;
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final product = state.product;
          final selectedVariation = state.selectedVariation;
          if (product == null || product.variations.length < 2) {
            return const SizedBox.shrink();
          }

          final details = product.specifications;
          String? attributeKey;

          if (details is ClothingDetails) {
            attributeKey = details.isTailored ? 'fabric' : 'size';
          } else if (details is ShoeDetails) {
            attributeKey = 'size';
          } else {
            attributeKey = null;
          }

          final sortedVariations = attributeKey != null
              ? _sortVariations(product.variations, attributeKey)
              : product.variations;

          return CircularImageSelector<ProductVariation>(
            items: sortedVariations,
            selectedItemId: selectedVariation?.id,
            idBuilder: (item) => item.id,
            onItemChanged: (selectedItem) {
              context.read<ProductDetailsCubit>().selectVariation(selectedItem);
            },
            labelBuilder: (item) {
              return item.attributes[attributeKey] ?? '';
            },
            imageBuilder: (item) {
              return item.imageUrls.isNotEmpty
                  ? item.imageUrls.first
                  : 'https://i.imgur.com/sN3d5tI.png';
            },
          );
        },
      );
}
