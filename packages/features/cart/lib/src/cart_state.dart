// cart_state.dart
part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final List<CartItem> items;

  const CartSuccess(this.items);

  int get totalItemsInCart => items.fold(0, (sum, item) => sum + item.quantity);

  int get selectedItemsCount => items
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + item.quantity);

  double get selectedItemsTotalPrice => items
      .where((item) => item.isSelected)
      .fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
}

final class CartFailure extends CartState {
  final String message;

  const CartFailure(this.message);
}

final class CartEmpty extends CartState {}

final class NotAuthenticated extends CartState {}
