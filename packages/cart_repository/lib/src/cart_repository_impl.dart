import 'dart:math';

import 'package:cart_repository/cart_repository.dart';
import 'package:domain_models/src/cart.dart';

final class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl();
  @override
  Future<void> addItemToCart({
    required String productId,
    int quantity = 1,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (Random().nextBool()) {
      print('Added item to cart: $productId, quantity: $quantity');
    } else {
      throw Exception('Failed to add item to cart. Please try again.');
    }
  }

  @override
  Future<void> clearCart() {
    // TODO: implement clearCart
    throw UnimplementedError();
  }

  @override
  Future<Cart?> getCart() {
    // TODO: implement getCart
    throw UnimplementedError();
  }

  @override
  Future<void> removeItemFromCart(String cartItemId) {
    // TODO: implement removeItemFromCart
    throw UnimplementedError();
  }

  @override
  Future<void> updateItemQuantity(String cartItemId, int newQuantity) {
    // TODO: implement updateItemQuantity
    throw UnimplementedError();
  }
}
