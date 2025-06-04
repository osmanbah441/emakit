part of 'cart_cubit.dart';

enum CartStatus { initial, loading, loaded, error }

/// Represents the overall state of the cart feature.
class CartState {
  final CartStatus status;
  final Cart? cart;
  final dynamic errorMessage;

  const CartState({
    this.status = CartStatus.initial,
    this.cart,
    this.errorMessage,
  });

  // Helper method to create new states with updated values
  CartState copyWith({CartStatus? status, Cart? cart, dynamic errorMessage}) {
    return CartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
