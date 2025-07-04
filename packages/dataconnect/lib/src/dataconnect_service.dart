import 'dart:typed_data';

import 'package:dataconnect/src/category_repository.dart';
import 'package:dataconnect/src/default_connector/default.dart';
import 'package:domain_models/domain_models.dart';
import 'package:functions/functions.dart';

import 'product_repository.dart';

final class DataconnectService {
  const DataconnectService._()
    : productRepository = const ProductRepository(),
      categoryRepository = const CategoryRepository();

  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;

  static const instance = DataconnectService._();

  static final _connector = DefaultConnector.instance;
  static final _fn = MooemartFunctions.instance;

  static void useEmulator(String host, int port) {
    DefaultConnector.instance.dataConnect.useDataConnectEmulator(host, port);
  }

  Future<ProcessGuidelineImageResult> processGuidelineImage(
    Uint8List bytes,
    String mimeType,
  ) async {
    return await _fn.processGuidelineImage([
      MooemartMediaPart(bytes, mimeType),
    ]);
  }
  // Cart

  Future<void> addToCart(ProductVariation p, int quantity) async =>
      await _connector
          .addCartItem(
            unitPrice: p.price,
            quantity: quantity,
            variationId: p.id,
          )
          .execute();

  Future<void> toggleWishlistStatus(String productId) async {}

  Future<Cart> fetchUserCart() async {
    return await _connector.fetchCart().execute().then((result) {
      final cart = result.data.cart;
      if (cart == null) {
        throw ('No cart found for the user');
      }

      final items = cart.items.map((item) {
        final variation = item.variation;
        final product = ProductVariation(
          id: variation.id,
          attributes: variation.attributes.value as Map<String, dynamic>,
          imageUrls: variation.imageUrls,
          price: variation.price,
          stockQuantity: variation.stockQuantity,
        );

        return CartItem(
          id: item.id,
          product: product,
          quantity: item.quantity,
          title: item.variation.product.name,
        );
      }).toList();

      return Cart(id: cart.id, items: items);
    });
  }

  Future<void> incrementCartItemQuantity(
    String cartItemId, {
    int quantity = 1,
  }) async {
    await _connector
        .incrementCartItemQuantity(cartItemId: cartItemId, quantity: quantity)
        .execute();
  }

  Future<void> decrementCartItemQuantity(
    String cartItemId, {
    int quantity = 1,
  }) async {
    await _connector
        .decrementCartItemQuantity(cartItemId: cartItemId, quantity: quantity)
        .execute();
  }

  Future<void> clearCart() async {
    await _connector.clearCart().execute();
  }

  Future<void> removeCartItem(String id) async {
    await _connector.removeCartItem(id: id).execute();
  }

  Future<UserRole?> get getCurrentUserRole async {
    // return null;
    return UserRole.admin;
  }
}
