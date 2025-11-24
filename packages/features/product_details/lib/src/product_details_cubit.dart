import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_repository/product_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:store_repository/store_repository.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({
    required this.productId,
    required ProductRepository productRepository,
    required OrderRepository orderRepository,
    required StoreRepository storeRepository,
    required CartRepository cartRepository,
  }) : _productRepository = productRepository,
       _orderRepository = orderRepository,
       _storeRepository = storeRepository,
       _cartRepository = cartRepository,
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

      // final store = await _storeRepository.getStoreById('');

      // // Set an initial variation when the product loads.
      // final initialVariation = null;

      emit(
        state.copyWith(
          product: product,
          // store: store,
          // selectedVariation: initialVariation,
          status: ActionStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: ActionStatus.failure));
    }
  }

  /// Updates the state with the user's chosen variation.
  void selectVariation(StoreVariation variation) {
    emit(state.copyWith(selectedVariation: variation));
  }

  // void setMeasurementUnit(MeasurementUnit unit) {
  //   emit(state.copyWith(measurementUnit: unit));
  // }

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
