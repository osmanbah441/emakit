import 'package:api/src/dataconnect_gen/default.dart';
import 'package:domain_models/domain_models.dart';

final class UserCommerceRepository {
  const UserCommerceRepository();
  static final _connector = DefaultConnector.instance;

  Future<void> addToCart(ProductVariation p, int quantity) async {
    // return await _connector
    //       .addCartItem(
    //         unitPrice: p.price,
    //         quantity: quantity,
    //         variationId: p.id,
    //       )
    //       .execute();
  }

  Future<void> toggleWishlistStatus(String productId) async {}

  Future<Cart> fetchUserCart() async {
    //   return await _connector.fetchCart().execute().then((result) {
    //     final cart = result.data.cart;
    //     if (cart == null) {
    //       throw ('No cart found for the user');
    //     }

    //     final items = cart.items.map((item) {
    //       final variation = item.variation;
    //       final product = ProductVariation(
    //         id: variation.id,
    //         attributes: variation.attributes.value is Map<String, dynamic>
    //             ? variation.attributes.value as Map<String, dynamic>
    //             : <String, dynamic>{},
    //         imageUrls: variation.imageUrls,
    //         price: variation.price,
    //         stockQuantity: variation.stockQuantity,
    //       );

    //       return CartItem(
    //         id: item.id,
    //         product: product,
    //         quantity: item.quantity,
    //         title: item.variation.product.name,
    //       );
    //     }).toList();

    //     return Cart(id: cart.id, items: items);
    //   });

    return Cart(id: 'id', items: []);
  }

  Future<void> incrementCartItemQuantity(
    String cartItemId, {
    int quantity = 1,
  }) async {
    // await _connector
    //     .incrementCartItemQuantity(cartItemId: cartItemId, quantity: quantity)
    //     .execute();
  }

  Future<void> decrementCartItemQuantity(
    String cartItemId, {
    int quantity = 1,
  }) async {
    // await _connector
    //     .decrementCartItemQuantity(cartItemId: cartItemId, quantity: quantity)
    //     .execute();
  }

  Future<void> clearCart() async {
    // await _connector.clearCart().execute();
  }

  Future<void> removeCartItem(String id) async {
    // await _connector.removeCartItem(id: id).execute();
  }
}
