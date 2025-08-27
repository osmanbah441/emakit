import 'package:domain_models/domain_models.dart';

import 'cart_repository_impl.dart';

abstract class CartRepository {
  const CartRepository._();

  static const CartRepository instance = CartRepositoryImpl();

  Future<Cart?> getCart();

  Future<void> addItemToCart({required String productId, int quantity = 1});

  Future<void> updateItemQuantity(String cartItemId, int newQuantity);

  Future<void> removeItemFromCart(String cartItemId);

  Future<void> clearCart();
}
