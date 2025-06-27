import 'package:dataconnect/src/default_connector/default.dart';
import 'package:domain_models/domain_models.dart';

import 'product_repository.dart';

final class DataconnectService {
  const DataconnectService._() : _productRepository = const ProductRepository();

  final ProductRepository _productRepository;

  static const instance = DataconnectService._();

  static final _connector = DefaultConnector.instance;

  static void useEmulator(String host, int port) {
    _connector.dataConnect.useDataConnectEmulator(host, port);
  }

  // Products
  Future<Product> fetchProductById(String id) async =>
      await _productRepository.fetchProductById(id);

  Future<List<Product>> fetchProducts({
    String searchTerm = '',
    String? categoryId,
  }) async => await _productRepository.fetchProducts(
    searchTerm: searchTerm,
    categoryId: categoryId,
  );

  Future<void> addProduct({
    required String name,
    required String description,
    required String subcategoryId,
    required String brand,
    required List<String> imageUrls,
    required double price,
    required int stockQuantity,
  }) async => await _productRepository.addProduct(
    name: name,
    description: description,
    subcategoryId: subcategoryId,
    brand: brand,
    imageUrls: imageUrls,
    price: price,
    stockQuantity: stockQuantity,
  );

  Future<void> addVariationForProduct({
    required String productId,
    required List<String> imageUrls,
    required double price,
    required int stockQuantity,
  }) async => await _productRepository.addVariationForProduct(
    productId: productId,
    imageUrls: imageUrls,
    price: price,
    stockQuantity: stockQuantity,
  );

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

  Future<List<Category>> fetchCategories() async {
    return await _connector.fetchCategories().execute().then((result) {
      return result.data.categories
          .map(
            (c) => Category(
              id: c.id,
              name: c.name,
              imageUrl: 'https://picsum.photos/id/237/200/300',
            ),
          )
          .toList();
    });
  }

  Future<List<Category>> fetchSubcategories(String parentId) async {
    return await _connector
        .fetchSubCategories(parentId: parentId)
        .execute()
        .then((results) {
          return results.data.categories
              .map(
                (c) => Category(
                  id: c.id,
                  name: c.name,
                  imageUrl: 'https://picsum.photos/id/237/200/300',
                ),
              )
              .toList();
        });
  }
}
