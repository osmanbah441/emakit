import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_repository/product_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:store_repository/store_repository.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.productId)
    : _productRepository = ProductRepository.instance,
      _orderRepository = OrderRepository.instance,
      _storeRepository = StoreRepository.instance,
      _cartRepository = CartRepository.instance,
      super(const ProductDetailsState()) {
    _loadProduct();
  }

  final ProductRepository _productRepository;
  final OrderRepository _orderRepository;
  final StoreRepository _storeRepository;
  final CartRepository _cartRepository;
  final String productId;

  Future<void> _loadProduct() async {
    try {
      emit(state.copyWith(status: ActionStatus.loading));
      final product = await _productRepository.getById(productId);
      if (product == null) {
        emit(
          state.copyWith(
            error: 'Product not found',
            status: ActionStatus.failure,
          ),
        );
        return;
      }

      final store = await _storeRepository.getStoreById('');

      // Set an initial variation when the product loads.
      final initialVariation = null;

      emit(
        state.copyWith(
          product: product,
          store: store,
          selectedVariation: initialVariation, // Set initial selection
          status: ActionStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: ActionStatus.failure));
    }
  }

  /// Updates the state with the user's chosen variation.
  void selectVariation(ProductVariation variation) {
    emit(state.copyWith(selectedVariation: variation));
  }

  void setMeasurementUnit(MeasurementUnit unit) {
    emit(state.copyWith(measurementUnit: unit));
  }

  Future<void> addToCart() async {
    // Guard against no selected variation.
    if (state.product == null || state.selectedVariation == null) {
      // Optionally emit a specific error for the UI to show.
      emit(
        state.copyWith(
          error: 'Please select a variation first.',
          status: ActionStatus.failure,
        ),
      );
      return;
    }
    try {
      emit(state.copyWith(status: ActionStatus.loading));
      // Use the selected variation's ID when adding to the cart.
      await _cartRepository.addItem(
        productId: state.product!.id,
        // variationId: state.selectedVariation!.id,
        quantity: 1,
      );
      emit(state.copyWith(status: ActionStatus.success));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: ActionStatus.failure));
    }
  }

  Future<void> buyNow() async {
    // This should be updated similarly to addToCart to use the selectedVariation
    if (state.product == null || state.selectedVariation == null) return;
    try {
      emit(state.copyWith(status: ActionStatus.loading));
      // final order = Order(
      //   id: 'order_${DateTime.now().millisecondsSinceEpoch}',
      //   date: DateTime.now(),
      //   // You would add order line items here using state.selectedVariation
      // );
      // await _orderRepository.createOrder(order);
      emit(state.copyWith(status: ActionStatus.success));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: ActionStatus.failure));
    }
  }
}
