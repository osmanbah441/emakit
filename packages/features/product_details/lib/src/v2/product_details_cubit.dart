// lib/product_details_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_repository/product_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.productId)
    : _productRepository = ProductRepository.instance,
      _orderRepository = OrderRepository.instance,
      super(const ProductDetailsState()) {
    _loadProduct();
  }

  final ProductRepository _productRepository;
  final OrderRepository _orderRepository;
  final String productId;

  Future<void> _loadProduct() async {
    try {
      emit(state.copyWith(status: ActionStatus.loading));
      final product = await _productRepository.getProductById(productId);
      emit(state.copyWith(product: product, status: ActionStatus.success));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: ActionStatus.failure));
    }
  }

  void setMeasurementUnit(MeasurementUnit unit) {
    emit(state.copyWith(measurementUnit: unit));
  }

  Future<void> addToCart() async {
    if (state.product == null) return;
    try {
      emit(state.copyWith(status: ActionStatus.loading));
      await _orderRepository.addItem(
        productId: state.product!.id!,
        quantity: 1,
      );
      emit(state.copyWith(status: ActionStatus.success));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: ActionStatus.failure));
    }
  }

  Future<void> buyNow() async {
    if (state.product == null) return;
    try {
      emit(state.copyWith(status: ActionStatus.loading));
      final order = Order(
        id: 'order_${DateTime.now().millisecondsSinceEpoch}',
        date: DateTime.now(),
      );
      await _orderRepository.createOrder(order);
      emit(state.copyWith(status: ActionStatus.success));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: ActionStatus.failure));
    }
  }
}
