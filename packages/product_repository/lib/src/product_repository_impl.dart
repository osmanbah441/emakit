import 'dart:typed_data';

import 'package:domain_models/domain_models.dart';
import 'product_repository.dart';

final List<Product> _allProducts = [
  // 1. A standard T-Shirt with MANY variations and IMAGES
  Product(
    id: 'prod_001',
    name: 'Cotton V-Neck T-Shirt',

    categoryId: 'women-tops-t-shirts',
    storeId: 'store_002',

    specifications: const ClothingDetails(isTailored: false),
    variations: [
      // White Color
      ProductVariation(
        id: 'var_001a',
        productId: 'prod_001',
        price: 250000,
        stockQuantity: 20,
        attributes: {'size': 'S', 'color': 'White'},
        imageUrls: [
          'https://picsum.photos/seed/prod_001_white_s_1/800',
          'https://picsum.photos/seed/prod_001_white_s_2/800',
          'https://picsum.photos/seed/prod_001_white_s_3/800',
        ],
      ),
      ProductVariation(
        id: 'var_001b',
        productId: 'prod_001',
        price: 250000,
        stockQuantity: 15,
        attributes: {'size': 'M', 'color': 'White'},
        imageUrls: [
          'https://picsum.photos/seed/prod_001_white_m_1/800',
          'https://picsum.photos/seed/prod_001_white_m_2/800',
          'https://picsum.photos/seed/prod_001_white_m_3/800',
        ],
      ),
      ProductVariation(
        id: 'var_001c',
        productId: 'prod_001',
        price: 250000,
        stockQuantity: 10,
        attributes: {'size': 'L', 'color': 'White'},
        imageUrls: [
          'https://picsum.photos/seed/prod_001_white_l_1/800',
          'https://picsum.photos/seed/prod_001_white_l_2/800',
        ],
      ),
      ProductVariation(
        id: 'var_001d',
        productId: 'prod_001',
        price: 250000,
        stockQuantity: 0, // Out of stock
        attributes: {'size': 'XL', 'color': 'White'},
        imageUrls: ['https://picsum.photos/seed/prod_001_white_xl_1/800'],
      ),
      // Black Color
      ProductVariation(
        id: 'var_001e',
        productId: 'prod_001',
        price: 260000,
        stockQuantity: 18,
        attributes: {'size': 'S', 'color': 'Black'},
        imageUrls: [
          'https://picsum.photos/seed/prod_001_black_s_1/800',
          'https://picsum.photos/seed/prod_001_black_s_2/800',
        ],
      ),
      ProductVariation(
        id: 'var_001f',
        productId: 'prod_001',
        price: 260000,
        stockQuantity: 22,
        attributes: {'size': 'M', 'color': 'Black'},
        imageUrls: [
          'https://picsum.photos/seed/prod_001_black_m_1/800',
          'https://picsum.photos/seed/prod_001_black_m_2/800',
        ],
      ),
      ProductVariation(
        id: 'var_001g',
        productId: 'prod_001',
        price: 260000,
        stockQuantity: 14,
        attributes: {'size': 'L', 'color': 'Black'},
        imageUrls: [
          'https://picsum.photos/seed/prod_001_black_l_1/800',
          'https://picsum.photos/seed/prod_001_black_l_2/800',
          'https://picsum.photos/seed/prod_001_black_l_3/800',
        ],
      ),
      ProductVariation(
        id: 'var_001h',
        productId: 'prod_001',
        price: 260000,
        stockQuantity: 9,
        attributes: {'size': 'XL', 'color': 'Black'},
        imageUrls: [
          'https://picsum.photos/seed/prod_001_black_xl_1/800',
          'https://picsum.photos/seed/prod_001_black_xl_2/800',
        ],
      ),
      // Navy Color
      ProductVariation(
        id: 'var_001i',
        productId: 'prod_001',
        price: 260000,
        stockQuantity: 11,
        attributes: {'size': 'M', 'color': 'Navy'},
        imageUrls: [
          'https://picsum.photos/seed/prod_001_navy_m_1/800',
          'https://picsum.photos/seed/prod_001_navy_m_2/800',
          'https://picsum.photos/seed/prod_001_navy_m_3/800',
        ],
      ),
      ProductVariation(
        id: 'var_001j',
        productId: 'prod_001',
        price: 260000,
        stockQuantity: 13,
        attributes: {'size': 'L', 'color': 'Navy'},
        imageUrls: [
          'https://picsum.photos/seed/prod_001_navy_l_1/800',
          'https://picsum.photos/seed/prod_001_navy_l_2/800',
          'https://picsum.photos/seed/prod_001_navy_l_3/800',
        ],
      ),
    ],
  ),
  // 2. A tailored dress with multiple images per fabric
  Product(
    id: 'prod_002',
    name: 'Custom Royal Gown',
    categoryId: 'women-dresses',
    storeId: 'store_001',

    specifications: const ClothingDetails(
      isTailored: true,
      requiredMeasurements: [
        MeasurementType.bust,
        MeasurementType.waist,
        MeasurementType.hip,
      ],
    ),
    variations: [
      ProductVariation(
        id: 'var_002a',
        productId: 'prod_002',
        price: 1200000,
        stockQuantity: 5,
        attributes: {'fabric': 'Ankara'},
        imageUrls: [
          'https://picsum.photos/seed/prod_002_ankara_1/800',
          'https://picsum.photos/seed/prod_002_ankara_2/800',
          'https://picsum.photos/seed/prod_002_ankara_3/800',
          'https://picsum.photos/seed/prod_002_ankara_4/800',
        ],
      ),
      ProductVariation(
        id: 'var_002b',
        productId: 'prod_002',
        price: 1500000,
        stockQuantity: 3,
        attributes: {'fabric': 'Brocade'},
        imageUrls: [
          'https://picsum.photos/seed/prod_002_brocade_1/800',
          'https://picsum.photos/seed/prod_002_brocade_2/800',
        ],
      ),
      ProductVariation(
        id: 'var_002c',
        productId: 'prod_002',
        price: 1800000,
        stockQuantity: 2,
        attributes: {'fabric': 'Lace'},
        imageUrls: [
          'https://picsum.photos/seed/prod_002_lace_1/800',
          'https://picsum.photos/seed/prod_002_lace_2/800',
          'https://picsum.photos/seed/prod_002_lace_3/800',
        ],
      ),
    ],
  ),
  // 3. A "one-of-a-kind" sample item
  Product(
    id: 'prod_003',
    name: 'Sample Evening Dress',
    categoryId: 'women-dresses',
    storeId: 'store_003',

    specifications: const ClothingDetails(isTailored: true),
    variations: [
      ProductVariation(
        id: 'var_003a',
        productId: 'prod_003',
        price: 1500000,
        stockQuantity: 1,
        attributes: {'bust': '34 inches', 'waist': '28 inches'},
        imageUrls: [
          'https://picsum.photos/seed/prod_003_main_1/800',
          'https://picsum.photos/seed/prod_003_main_2/800',
          'https://picsum.photos/seed/prod_003_main_3/800',
        ],
      ),
    ],
  ),
  // 4. A standard men's jacket
  Product(
    id: 'prod_004',
    name: 'Lightweight Bomber Jacket',
    categoryId: 'men-outerwear-jackets',
    storeId: 'store_002',

    specifications: const ClothingDetails(isTailored: false),
    variations: [
      ProductVariation(
        id: 'var_004a',
        productId: 'prod_004',
        price: 750000,
        stockQuantity: 10,
        attributes: {'size': 'M', 'color': 'Black'},
        imageUrls: [
          'https://picsum.photos/seed/prod_004_black_m_1/800',
          'https://picsum.photos/seed/prod_004_black_m_2/800',
        ],
      ),
      ProductVariation(
        id: 'var_004b',
        productId: 'prod_004',
        price: 750000,
        stockQuantity: 8,
        attributes: {'size': 'L', 'color': 'Black'},
        imageUrls: [
          'https://picsum.photos/seed/prod_004_black_l_1/800',
          'https://picsum.photos/seed/prod_004_black_l_2/800',
        ],
      ),
      ProductVariation(
        id: 'var_004e',
        productId: 'prod_004',
        price: 780000,
        stockQuantity: 6,
        attributes: {'size': 'XL', 'color': 'Olive'},
        imageUrls: [
          'https://picsum.photos/seed/prod_004_olive_xl_1/800',
          'https://picsum.photos/seed/prod_004_olive_xl_2/800',
        ],
      ),
    ],
  ),
  // 5. Classic Leather Loafers
  Product(
    id: 'prod_011',
    name: 'Classic Leather Loafers',
    categoryId: 'men-shoes-formal',
    storeId: 'store_001',

    specifications: const ShoeDetails(
      style: 'Loafer',
      material: 'Genuine Leather',
      sizeChart: {'EU': '42', 'US': '9', 'UK': '8'},
    ),
    variations: [
      ProductVariation(
        id: 'var_011b',
        productId: 'prod_011',
        price: 950000,
        stockQuantity: 8,
        attributes: {'color': 'Black', 'size': '42'},
        imageUrls: [
          'https://picsum.photos/seed/prod_011_black_42_1/800',
          'https://picsum.photos/seed/prod_011_black_42_2/800',
          'https://picsum.photos/seed/prod_011_black_42_3/800',
        ],
      ),
      ProductVariation(
        id: 'var_011e',
        productId: 'prod_011',
        price: 980000,
        stockQuantity: 9,
        attributes: {'color': 'Brown', 'size': '43'},
        imageUrls: [
          'https://picsum.photos/seed/prod_011_brown_43_1/800',
          'https://picsum.photos/seed/prod_011_brown_43_2/800',
          'https://picsum.photos/seed/prod_011_brown_43_3/800',
        ],
      ),
    ],
  ),
  // 6. Reversible Leather Belt
  Product(
    id: 'prod_012',
    name: 'Reversible Leather Belt',
    categoryId: 'men-accessories-belts',
    storeId: 'store_002',

    specifications: null,
    variations: [
      ProductVariation(
        id: 'var_012a',
        productId: 'prod_012',
        price: 450000,
        stockQuantity: 15,
        attributes: {'color': 'Black'},
        imageUrls: [
          'https://picsum.photos/seed/prod_012_black_1/800',
          'https://picsum.photos/seed/prod_012_black_2/800',
        ],
      ),
      ProductVariation(
        id: 'var_012b',
        productId: 'prod_012',
        price: 450000,
        stockQuantity: 11,
        attributes: {'color': 'Brown'},
        imageUrls: [
          'https://picsum.photos/seed/prod_012_brown_1/800',
          'https://picsum.photos/seed/prod_012_brown_2/800',
          'https://picsum.photos/seed/prod_012_brown_3/800',
        ],
      ),
      ProductVariation(
        id: 'var_012c',
        productId: 'prod_012',
        price: 450000,
        stockQuantity: 9,
        attributes: {'color': 'Tan'},
        imageUrls: [
          'https://picsum.photos/seed/prod_012_tan_1/800',
          'https://picsum.photos/seed/prod_012_tan_2/800',
        ],
      ),
    ],
  ),
];

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl();

  @override
  Future<List<Product>> getAllProducts({
    String? searchTerm,
    String? categoryId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    List<Product> results = List.from(_allProducts);

    if (categoryId != null) {
      results = results
          .where((p) => p.categoryId.toLowerCase() == categoryId.toLowerCase())
          .toList();
    }

    if (searchTerm != null && searchTerm.isNotEmpty) {
      results = results
          .where((p) => p.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
    return results;
  }

  @override
  Future<Product?> getProductById(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _allProducts.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createNewProduct({
    required String name,
    required String description,
    required Map<String, dynamic> specs,
    required Map<String, dynamic> attributes,
    required String category,
    required List<({Uint8List bytes, String mimeType})> imagesData,
    required double price,
    required int availableStock,
  }) {
    // TODO: implement createNewProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String productId) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<Product>>> getProductsForAllCateggeories() {
    // TODO: implement getProductsForAllCateggeories
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getAllProductsFromSubCategories(
    List<String> ids,
  ) async {
    final products = <Product>[];
    for (var id in ids) {
      final p = await getAllProducts(categoryId: id);
      products.addAll(p);
    }

    return products;
  }
}
