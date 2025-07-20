import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain_models/domain_models.dart';

final class FirestoreProductCollection {
  const FirestoreProductCollection();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _productsCollection = 'products';
  static const String _variationsSubcollection = 'variations';

  Future<String> createNewProduct({
    required String name,
    required String description,
    required String subcategoryId,
    required String imageUrl,
    required Map<String, dynamic> specs,
    ProductStatus status = ProductStatus.draft,
  }) async {
    final productData = {
      'name': name,
      'description': description,
      'categoryId': subcategoryId,
      'mainImage': imageUrl,
      'specifications': specs,
      'status': status.name,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final docRef = await _firestore
        .collection(_productsCollection)
        .add(productData);
    return docRef.id;
  }

  Future<void> createNewProductVariation({
    required String productId,
    required List<String> imageUrls,
    required double price,
    required int availabeStock,
    required Map<String, dynamic> attributes,
    required String storeId,
    ProductStatus status = ProductStatus.active,
  }) async {
    final variationData = {
      'productId': productId,
      'imageUrls': imageUrls,
      'price': price,
      'stockQuantity': availabeStock,
      'attributes': attributes,
      'storeId': storeId,
      'status': status.name,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await _firestore
        .collection(_productsCollection)
        .doc(productId)
        .collection(_variationsSubcollection)
        .add(variationData);
  }

  Future<List<Product>> getAllProducts({
    String searchTerm = '',
    String? categoryId,
    ProductStatus? productStatusFilter,
  }) async {
    Query<Map<String, dynamic>> productsQuery = _firestore.collection(
      _productsCollection,
    );

    if (categoryId != null && categoryId.isNotEmpty) {
      productsQuery = productsQuery.where('categoryId', isEqualTo: categoryId);
    }

    if (productStatusFilter != null) {
      productsQuery = productsQuery.where(
        'status',
        isEqualTo: productStatusFilter.name,
      );
    }

    if (searchTerm.isNotEmpty) {
      productsQuery = productsQuery
          .where('name', isGreaterThanOrEqualTo: searchTerm)
          .where('name', isLessThanOrEqualTo: searchTerm + '\uf8ff');
    }

    final productsSnapshot = await productsQuery.get();

    final products = <Product>[];
    for (var doc in productsSnapshot.docs) {
      final productData = doc.data();
      final productId = doc.id;

      final variations = await _fetchProductVariations(productId);

      products.add(
        Product(
          id: productId,
          name: productData['name'] as String,
          description: productData['description'] as String,
          specifications: Map<String, dynamic>.from(
            productData['specifications'] ?? {},
          ),
          variations: variations,
          status: ProductStatus.fromString(productData['status'] as String),
        ),
      );
    }
    return products;
  }

  Future<Product> getProductById(String id) async {
    final productDoc = await _firestore
        .collection(_productsCollection)
        .doc(id)
        .get();

    if (!productDoc.exists) {
      throw ('No product found with ID: $id');
    }

    final productData = productDoc.data()!;
    final productId = productDoc.id;

    final variations = await _fetchProductVariations(productId);

    return Product(
      id: productId,
      name: productData['name'] as String,
      description: productData['description'] as String,
      specifications: Map<String, dynamic>.from(
        productData['specifications'] ?? {},
      ),
      variations: variations,
      status: ProductStatus.fromString(productData['status'] as String),
    );
  }

  // Helper method to fetch and map product variations
  Future<List<ProductVariation>> _fetchProductVariations(
    String productId,
  ) async {
    final variationsSnapshot = await _firestore
        .collection(_productsCollection)
        .doc(productId)
        .collection(_variationsSubcollection)
        .get();

    return variationsSnapshot.docs.map((vDoc) {
      final vData = vDoc.data();
      return ProductVariation(
        id: vDoc.id,
        attributes: Map<String, dynamic>.from(vData['attributes'] ?? {}),
        imageUrls: List<String>.from(vData['imageUrls'] ?? []),
        price: (vData['price'] as num).toDouble(),
        stockQuantity: (vData['stockQuantity'] as num).toInt(),
        productId: productId,
        status: ProductStatus.fromString(vData['status'] as String),
      );
    }).toList();
  }
}
