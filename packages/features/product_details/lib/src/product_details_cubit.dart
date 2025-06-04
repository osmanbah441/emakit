import 'dart:collection';

import 'package:dataconnect/dataconnect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';

part 'product_details_state.dart';
part 'extension_on_product.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsState());

  final _connector = DataconnectService.instance;

  void loadProduct(String productId) async {
    emit(state.copyWith(status: ProductDetailsStatus.loading));
    try {
      final productData = await _connector.fetchProductById(productId);
      final variations = productData.variations;

      final sortedAvailableAttributes = productData
          .extractSortAvailableAttributes();

      final initialSelectedAttributes = <String, dynamic>{};
      final initialVariation = productData.determineInitialVariation(
        initialSelectedAttributes,
      );

      emit(
        state.copyWith(
          status: ProductDetailsStatus.success,
          product: productData,
          allVariations: variations,
          availableAttributes: sortedAvailableAttributes,
          currentSelectedAttributes: initialSelectedAttributes,
          selectedVariation: initialVariation,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductDetailsStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  void updateSelectedAttribute(String attributeKey, dynamic attributeValue) {
    if (state.product == null) return;

    final newSelectedAttributes = Map<String, dynamic>.from(
      state.currentSelectedAttributes,
    );
    newSelectedAttributes[attributeKey] = attributeValue;

    final matchedVariation = state.product!.findMatchingVariation(
      newSelectedAttributes,
    );

    emit(
      state.copyWith(
        currentSelectedAttributes: newSelectedAttributes,
        selectedVariation: matchedVariation,
        clearSelectedVariation: matchedVariation == null,
      ),
    );
  }

  void addToCart(ProductVariation p) async {
    await _connector.addToCart(p, 1);
  }
}
