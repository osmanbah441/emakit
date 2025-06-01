// import 'package:domain_models/domain_models.dart';

import 'package:backend/src/models/product.dart';

import 'generated/default.dart';

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

  Future<List<Product>> fetchProducts({String searchTerm = ''}) async =>
      await _connector.fetchProducts().execute().then(
        (results) => results.data.products
            .map(
              (p) => Product(
                id: p.id,
                name: p.name,
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

  Future<Product> fetchProductById(String id) async =>
      await _connector.fetchProduct(id: id).execute().then((result) {
        final p = result.data.product;
        if (p == null) throw ('No product found');
        return Product(
          id: p.id,
          name: p.name,
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

  Future<void> toggleCartStatus(String productId) async {
    if (_cart.contains(productId)) {
      _cart.remove(productId);
    } else {
      _cart.add(productId);
    }

    print('you have ${_cart.length} items');
  }

  // --- Wishlist Management ---
  Future<void> toggleWishlistStatus(String productId) async {
    if (_wishlist.contains(productId)) {
      _wishlist.add(productId);
    } else {
      _wishlist.remove(productId);
    }

    print('you have ${_wishlist.length} items');
  }
}

// Internal sets to manage cart and wishlist product IDs
final Set<String> _cart = {};
final Set<String> _wishlist = {};
