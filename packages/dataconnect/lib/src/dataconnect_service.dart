import 'package:dataconnect/src/dataconnect-generated/default_connector/default.dart';
import 'package:domain_models/domain_models.dart';

final class DataconnectService {
  const DataconnectService._();

  static const instance = DataconnectService._();

  static final _connector = DefaultConnector.instance;

  static void useEmulator(String host, int port) {
    _connector.dataConnect.useDataConnectEmulator(host, port);
  }

  Future<void> addCategory({
    required String name,
    String? parentId,
    String? description,
  }) async {
    await _connector
        .addNewCategory(name: name)
        .parentId(parentId)
        .description(description)
        .execute();
  }

  Future<void> addProduct({
    required String name,
    required String description,
    required String subcategoryId,
    required String brand,
    required List<String> imageUrls,
    required double price,
    required int stockQuantity,
  }) async {
    final productId = await _connector
        .addNewProduct(
          name: name,
          description: description,
          category: subcategoryId,
          brand: brand,
        )
        .execute()
        .then((result) {
          return result.data.product_insert.id;
        });

    // add default variation
    await addVariationForProduct(
      productId: productId,
      imageUrls: imageUrls,
      price: price,
      stockQuantity: stockQuantity,
    );
  }

  Future<void> addVariationForProduct({
    required String productId,
    required List<String> imageUrls,
    required double price,
    required int stockQuantity,
  }) async {
    await _connector
        .addNewProductVariation(
          productId: productId,
          imageUrls: imageUrls,
          price: price,
          stockQuantity: stockQuantity,
        )
        .execute();
  }

  Future<List<Product>> fetchProducts({
    String searchTerm = '',
    String? categoryId,
    String? mainCategoryId,
  }) async {
    var query = _connector.fetchProducts();
    if (categoryId != null) query = query.categoryId(categoryId);
    if (mainCategoryId != null) query = query.mainCategoryId(mainCategoryId);

    return await query.execute().then(
      (result) => result.data.products
          .map(
            (p) => Product(
              id: p.id,
              name: p.name,
              mainCategory: p.mainCategory.name,
              description: p.description,
              specifications: p.specifications.value as Map<String, dynamic>,
              variations: p.variations
                  .map(
                    (v) => ProductVariation(
                      id: v.id,
                      attributes: v.attributes.value,
                      imageUrls: v.imageUrls,
                      price: v.price,
                      stockQuantity: v.stockQuantity,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  Future<Product> fetchProductById(String id) async =>
      await _connector.fetchProduct(id: id).execute().then((result) {
        final p = result.data.product;
        if (p == null) throw ('No product found');
        return Product(
          id: p.id,
          name: p.name,
          mainCategory: p.mainCategory.name,

          description: p.description,
          specifications: p.specifications.value as Map<String, dynamic>,
          variations: p.variations
              .map(
                (v) => ProductVariation(
                  id: v.id,
                  attributes: v.attributes.value,
                  imageUrls: v.imageUrls,
                  price: v.price,
                  stockQuantity: v.stockQuantity,
                ),
              )
              .toList(),
        );
      });

  Future<void> addToCart(ProductVariation p, int quantity) async =>
      await _connector
          .addCartItem(
            unitPrice: p.price,
            quantity: quantity,
            variationId: p.id,
          )
          .execute();

  Future<void> toggleCartStatus(String productId) async {}

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
