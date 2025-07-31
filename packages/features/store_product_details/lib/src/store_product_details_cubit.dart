import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:api/api.dart';

part 'store_product_details_state.dart';

class StoreProductDetailsCubit extends Cubit<StoreProductDetailsState> {
  StoreProductDetailsCubit(this.productId)
    : super(const StoreProductDetailsState()) {
    _loadProductData();
  }

  final String productId;

  final _productRepository = Api.instance.productRepository;

  void _loadProductData() async {
    emit(state.copyWith(status: StoreProductDetailsStatus.loading));
    try {
      final p = await _productRepository.getProductDetailsForStore(productId);
      emit(
        state.copyWith(
          product: p.product,
          status: StoreProductDetailsStatus.success,
          variationDefinationFields: p.attributeDefinationFields,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StoreProductDetailsStatus.error,
          error: "Failed to load data",
        ),
      );
    }
  }

  void refect() async => _loadProductData();

  void addVariation({
    required double price,
    required int stock,
    required Map<String, dynamic> selectedAttributesMap,
    required List<({Uint8List bytes, String mimeType})> images,
  }) async {
    emit(state.copyWith(status: StoreProductDetailsStatus.loading));

    try {
      await _productRepository.createNewProductVariation(
        productId: productId,
        price: price,
        availableStock: stock,
        attributes: selectedAttributesMap,
        images: images,
      );
      refect();
    } catch (e) {
      emit(
        state.copyWith(
          status: StoreProductDetailsStatus.error,
          error: "Failed to add variation",
        ),
      );
    }
  }

  void updateVariation({
    required String id,
    required double price,
    required int stock,
  }) async {}

  void deleteVariation(String id) async {}

  void toggleActive(String id, bool isActive) async {}
}
