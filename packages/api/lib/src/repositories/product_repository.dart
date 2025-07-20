import 'package:api/api.dart';

import 'package:api/src/functions/models.dart';
import 'package:domain_models/domain_models.dart';

import '../firestore/product.dart';
import '../functions/functions.dart';

final class ProductRepository {
  const ProductRepository();

  static final _fn = Functions.instance;
  static final _products = FirestoreProductCollection();

  // Ensure your Product, ProductVariation, and ProductStatus classes are defined in your Dart file.

  static final List<Product> products = [
    // 1. Laptop
    Product(
      id: 'prod_laptop_001',
      name: 'UltraBook Pro 2025',
      description:
          'Sleek, powerful, and designed for peak performance. Ideal for professionals.',
      categoryId: 'electronics',
      imageUrl: 'https://picsum.photos/id/1/800/600',
      status: ProductStatus.active,
      specifications: {
        'brand': 'TechGiant',
        'processor': 'Intel i9 15th Gen',
        'ram': '32GB DDR5',
        'storage_type': 'NVMe SSD',
        'screen_size': '15.6 inch',
        'operating_system': 'Windows 11 Pro',
      },
      variations: [
        ProductVariation(
          id: 'var_laptop_001_silver_512',
          productId: 'prod_laptop_001',
          status: ProductStatus.active,
          attributes: {'color': 'Silver', 'storage': '512GB'},
          imageUrls: [
            'https://picsum.photos/id/2/700/500',
            'https://picsum.photos/id/3/700/500',
            'https://picsum.photos/id/4/700/500',
            'https://picsum.photos/id/5/700/500',
          ],
          price: 1899.99,
          stockQuantity: 45,
          storeId: 'store_compuworld',
          storeName: 'CompuWorld',
        ),
        ProductVariation(
          id: 'var_laptop_001_spacegray_1tb',
          productId: 'prod_laptop_001',
          status: ProductStatus.active,
          attributes: {'color': 'Space Gray', 'storage': '1TB'},
          imageUrls: [
            'https://picsum.photos/id/6/700/500',
            'https://picsum.photos/id/7/700/500',
            'https://picsum.photos/id/8/700/500',
            'https://picsum.photos/id/9/700/500',
            'https://picsum.photos/id/10/700/500',
          ],
          price: 2199.99,
          stockQuantity: 30,
          storeId: 'store_compuworld',
          storeName: 'CompuWorld',
        ),
      ],
    ),

    // 2. Coffee Mug
    Product(
      id: 'prod_mug_002',
      name: 'Ergonomic Ceramic Coffee Mug',
      description:
          'Your perfect companion for morning coffee or evening tea. Dishwasher safe.',
      categoryId: 'kitchenware',
      imageUrl: 'https://picsum.photos/id/11/500/500',
      status: ProductStatus.active,
      specifications: {
        'material': 'Ceramic',
        'capacity_ml': 350,
        'microwave_safe': true,
      },
      variations: [
        ProductVariation(
          id: 'var_mug_002_white',
          productId: 'prod_mug_002',
          status: ProductStatus.active,
          attributes: {'color': 'White', 'finish': 'Glossy'},
          imageUrls: [
            'https://picsum.photos/id/12/400/400',
            'https://picsum.photos/id/13/400/400',
            'https://picsum.photos/id/14/400/400',
            'https://picsum.photos/id/15/400/400',
          ],
          price: 12.50,
          stockQuantity: 200,
          storeId: 'store_homestuff',
          storeName: 'Home Essentials',
        ),
        ProductVariation(
          id: 'var_mug_002_black',
          productId: 'prod_mug_002',
          status: ProductStatus.active,
          attributes: {'color': 'Matte Black', 'finish': 'Matte'},
          imageUrls: [
            'https://picsum.photos/id/16/400/400',
            'https://picsum.photos/id/17/400/400',
            'https://picsum.photos/id/18/400/400',
            'https://picsum.photos/id/19/400/400',
          ],
          price: 13.00,
          stockQuantity: 150,
          storeId: 'store_homestuff',
          storeName: 'Home Essentials',
        ),
      ],
    ),

    // 3. Backpack
    Product(
      id: 'prod_backpack_003',
      name: 'Adventure-Ready Commuter Backpack',
      description:
          'Durable, spacious, and weather-resistant. Perfect for daily commute or weekend trips.',
      categoryId: 'accessories',
      imageUrl: 'https://picsum.photos/id/20/700/500',
      status: ProductStatus.active,
      specifications: {
        'material': 'Water-resistant Nylon',
        'capacity_liters': 25,
        'laptop_sleeve': '15 inch',
        'pockets': 'Multiple internal and external',
      },
      variations: [
        ProductVariation(
          id: 'var_backpack_003_navy',
          productId: 'prod_backpack_003',
          status: ProductStatus.active,
          attributes: {'color': 'Navy Blue'},
          imageUrls: [
            'https://picsum.photos/id/21/600/450',
            'https://picsum.photos/id/22/600/450',
            'https://picsum.photos/id/23/600/450',
            'https://picsum.photos/id/24/600/450',
          ],
          price: 65.00,
          stockQuantity: 80,
          storeId: 'store_outdoor',
          storeName: 'Outdoor Gear Pro',
        ),
        ProductVariation(
          id: 'var_backpack_003_olive',
          productId: 'prod_backpack_003',
          status: ProductStatus.active,
          attributes: {'color': 'Olive Green'},
          imageUrls: [
            'https://picsum.photos/id/25/600/450',
            'https://picsum.photos/id/26/600/450',
            'https://picsum.photos/id/27/600/450',
            'https://picsum.photos/id/28/600/450',
          ],
          price: 65.00,
          stockQuantity: 60,
          storeId: 'store_outdoor',
          storeName: 'Outdoor Gear Pro',
        ),
      ],
    ),

    // 4. Smartwatch
    Product(
      id: 'prod_smartwatch_004',
      name: 'ConnectBand Pro X',
      description:
          'Track your fitness, receive notifications, and make payments from your wrist.',
      categoryId: 'electronics',
      imageUrl: 'https://picsum.photos/id/29/600/400',
      status: ProductStatus.active,
      specifications: {
        'display_type': 'AMOLED',
        'battery_life_days': 7,
        'water_resistance_atm': 5,
        'features': ['Heart Rate Monitor', 'GPS', 'NFC'],
      },
      variations: [
        ProductVariation(
          id: 'var_watch_004_black',
          productId: 'prod_smartwatch_004',
          status: ProductStatus.active,
          attributes: {'case_color': 'Black', 'band_material': 'Silicone'},
          imageUrls: [
            'https://picsum.photos/id/30/500/350',
            'https://picsum.photos/id/31/500/350',
            'https://picsum.photos/id/32/500/350',
            'https://picsum.photos/id/33/500/350',
          ],
          price: 199.99,
          stockQuantity: 90,
          storeId: 'store_techhaven',
          storeName: 'Tech Haven',
        ),
        ProductVariation(
          id: 'var_watch_004_silver',
          productId: 'prod_smartwatch_004',
          status: ProductStatus.active,
          attributes: {
            'case_color': 'Silver',
            'band_material': 'Stainless Steel',
          },
          imageUrls: [
            'https://picsum.photos/id/34/500/350',
            'https://picsum.photos/id/35/500/350',
            'https://picsum.photos/id/36/500/350',
            'https://picsum.photos/id/37/500/350',
            'https://picsum.photos/id/38/500/350',
          ],
          price: 229.99,
          stockQuantity: 70,
          storeId: 'store_techhaven',
          storeName: 'Tech Haven',
        ),
      ],
    ),

    // 5. Indoor Plant
    Product(
      id: 'prod_plant_005',
      name: 'Majestic Monstera Deliciosa',
      description:
          'A beautiful tropical plant known for its large, unique leaves. Adds a vibrant touch to any room.',
      categoryId: 'home_decor',
      imageUrl: 'https://picsum.photos/id/39/500/600',
      status: ProductStatus.active,
      specifications: {
        'plant_type': 'Monstera Deliciosa',
        'care_level': 'Medium',
        'light_requirements': 'Bright, indirect sunlight',
        'pot_size_inches': 8,
      },
      variations: [
        ProductVariation(
          id: 'var_plant_005_small',
          productId: 'prod_plant_005',
          status: ProductStatus.active,
          attributes: {'size': 'Small', 'pot_type': 'Terracotta'},
          imageUrls: [
            'https://picsum.photos/id/40/450/550',
            'https://picsum.photos/id/41/450/550',
            'https://picsum.photos/id/42/450/550',
            'https://picsum.photos/id/43/450/550',
          ],
          price: 35.00,
          stockQuantity: 50,
          storeId: 'store_greenhouse',
          storeName: 'The Green House',
        ),
        ProductVariation(
          id: 'var_plant_005_medium',
          productId: 'prod_plant_005',
          status: ProductStatus.active,
          attributes: {'size': 'Medium', 'pot_type': 'Ceramic'},
          imageUrls: [
            'https://picsum.photos/id/44/450/550',
            'https://picsum.photos/id/45/450/550',
            'https://picsum.photos/id/46/450/550',
            'https://picsum.photos/id/47/450/550',
          ],
          price: 55.00,
          stockQuantity: 30,
          storeId: 'store_greenhouse',
          storeName: 'The Green House',
        ),
      ],
    ),

    // 6. Headphones
    Product(
      id: 'prod_headphones_006',
      name: 'SonicWave Noise-Cancelling Headphones',
      description:
          'Immerse yourself in pure sound with industry-leading noise cancellation and comfortable design.',
      categoryId: 'audio',
      imageUrl: 'https://picsum.photos/id/48/700/500',
      status: ProductStatus.active,
      specifications: {
        'connection_type': 'Bluetooth 5.3',
        'battery_life_hours': 40,
        'features': [
          'Active Noise Cancellation',
          'Ambient Sound Mode',
          'Voice Assistant',
        ],
        'driver_size_mm': 40,
      },
      variations: [
        ProductVariation(
          id: 'var_headphone_006_black',
          productId: 'prod_headphones_006',
          status: ProductStatus.active,
          attributes: {'color': 'Black'},
          imageUrls: [
            'https://picsum.photos/id/49/600/400',
            'https://picsum.photos/id/50/600/400',
            'https://picsum.photos/id/51/600/400',
            'https://picsum.photos/id/52/600/400',
          ],
          price: 249.00,
          stockQuantity: 120,
          storeId: 'store_soundhub',
          storeName: 'Sound Hub',
        ),
        ProductVariation(
          id: 'var_headphone_006_white',
          productId: 'prod_headphones_006',
          status: ProductStatus.active,
          attributes: {'color': 'White'},
          imageUrls: [
            'https://picsum.photos/id/53/600/400',
            'https://picsum.photos/id/54/600/400',
            'https://picsum.photos/id/55/600/400',
            'https://picsum.photos/id/56/600/400',
          ],
          price: 249.00,
          stockQuantity: 90,
          storeId: 'store_soundhub',
          storeName: 'Sound Hub',
        ),
      ],
    ),

    // 7. Board Game
    Product(
      id: 'prod_boardgame_007',
      name: 'Chronicles of Eldoria: The Lost Artefacts',
      description:
          'An epic cooperative board game for 1-4 players. Dive into a world of magic and adventure!',
      categoryId: 'toys_games',
      imageUrl: 'https://picsum.photos/id/57/600/450',
      status: ProductStatus.active,
      specifications: {
        'player_count': '1-4 players',
        'playing_time_minutes': '60-120',
        'age_recommendation': '12+',
        'genre': 'Fantasy, Cooperative',
      },
      variations: [
        ProductVariation(
          id: 'var_boardgame_007_base',
          productId: 'prod_boardgame_007',
          status: ProductStatus.active,
          attributes: {'edition': 'Base Game'},
          imageUrls: [
            'https://picsum.photos/id/58/550/400',
            'https://picsum.photos/id/59/550/400',
            'https://picsum.photos/id/60/550/400',
            'https://picsum.photos/id/61/550/400',
          ],
          price: 49.99,
          stockQuantity: 70,
          storeId: 'store_gameworld',
          storeName: 'Game World',
        ),
        ProductVariation(
          id: 'var_boardgame_007_expansion',
          productId: 'prod_boardgame_007',
          status: ProductStatus.inactive,
          attributes: {'edition': 'Forgotten Isles Expansion'},
          imageUrls: [
            'https://picsum.photos/id/62/550/400',
            'https://picsum.photos/id/63/550/400',
            'https://picsum.photos/id/64/550/400',
            'https://picsum.photos/id/65/550/400',
          ],
          price: 29.99,
          stockQuantity: 0,
          storeId: 'store_gameworld',
          storeName: 'Game World',
        ),
      ],
    ),

    // 8. Water Bottle
    Product(
      id: 'prod_bottle_008',
      name: 'EcoHydro Stainless Steel Water Bottle',
      description:
          'Keep your drinks cold for 24 hours or hot for 12. Sustainable and stylish.',
      categoryId: 'sports_outdoor',
      imageUrl: 'https://picsum.photos/id/66/500/700',
      status: ProductStatus.active,
      specifications: {
        'material': 'Food-Grade Stainless Steel',
        'capacity_ml': 750,
        'insulation': 'Double-Wall Vacuum',
        'leak_proof': true,
      },
      variations: [
        ProductVariation(
          id: 'var_bottle_008_mint',
          productId: 'prod_bottle_008',
          status: ProductStatus.active,
          attributes: {'color': 'Mint Green', 'cap_type': 'Straw Lid'},
          imageUrls: [
            'https://picsum.photos/id/67/400/600',
            'https://picsum.photos/id/68/400/600',
            'https://picsum.photos/id/69/400/600',
            'https://picsum.photos/id/70/400/600',
          ],
          price: 25.00,
          stockQuantity: 110,
          storeId: 'store_hydration',
          storeName: 'Hydration Central',
        ),
        ProductVariation(
          id: 'var_bottle_008_midnight',
          productId: 'prod_bottle_008',
          status: ProductStatus.active,
          attributes: {'color': 'Midnight Blue', 'cap_type': 'Flip Lid'},
          imageUrls: [
            'https://picsum.photos/id/71/400/600',
            'https://picsum.photos/id/72/400/600',
            'https://picsum.photos/id/73/400/600',
            'https://picsum.photos/id/74/400/600',
          ],
          price: 24.50,
          stockQuantity: 95,
          storeId: 'store_hydration',
          storeName: 'Hydration Central',
        ),
      ],
    ),

    // 9. T-Shirt
    Product(
      id: 'prod_tshirt_009',
      name: 'Organic Cotton Classic Tee',
      description:
          'Soft, breathable, and sustainably sourced. A wardrobe essential.',
      categoryId: 'apparel',
      imageUrl: 'https://picsum.photos/id/75/500/600',
      status: ProductStatus.active,
      specifications: {
        'material': '100% Organic Cotton',
        'fit': 'Regular Fit',
        'neckline': 'Crew Neck',
        'wash_instructions': 'Machine wash cold',
      },
      variations: [
        ProductVariation(
          id: 'var_tshirt_009_white_m',
          productId: 'prod_tshirt_009',
          status: ProductStatus.active,
          attributes: {'color': 'White', 'size': 'M'},
          imageUrls: [
            'https://picsum.photos/id/76/450/550',
            'https://picsum.photos/id/77/450/550',
            'https://picsum.photos/id/78/450/550',
            'https://picsum.photos/id/79/450/550',
          ],
          price: 19.99,
          stockQuantity: 100,
          storeId: 'store_stylezone',
          storeName: 'StyleZone Apparel',
        ),
        ProductVariation(
          id: 'var_tshirt_009_black_l',
          productId: 'prod_tshirt_009',
          status: ProductStatus.active,
          attributes: {'color': 'Black', 'size': 'L'},
          imageUrls: [
            'https://picsum.photos/id/80/450/550',
            'https://picsum.photos/id/81/450/550',
            'https://picsum.photos/id/82/450/550',
            'https://picsum.photos/id/83/450/550',
          ],
          price: 19.99,
          stockQuantity: 80,
          storeId: 'store_stylezone',
          storeName: 'StyleZone Apparel',
        ),
        ProductVariation(
          id: 'var_tshirt_009_gray_xl',
          productId: 'prod_tshirt_009',
          status: ProductStatus.outOfStock,
          attributes: {'color': 'Heather Gray', 'size': 'XL'},
          imageUrls: [
            'https://picsum.photos/id/84/450/550',
            'https://picsum.photos/id/85/450/550',
            'https://picsum.photos/id/86/450/550',
            'https://picsum.photos/id/87/450/550',
          ],
          price: 19.99,
          stockQuantity: 0,
          storeId: 'store_stylezone',
          storeName: 'StyleZone Apparel',
        ),
      ],
    ),

    // 10. Scented Candle
    Product(
      id: 'prod_candle_010',
      name: 'Aromatherapy Soy Candle',
      description:
          'Hand-poured with natural soy wax and essential oils for a calming ambiance.',
      categoryId: 'home_decor',
      imageUrl: 'https://picsum.photos/id/88/500/500',
      status: ProductStatus.active,
      specifications: {
        'wax_type': '100% Soy Wax',
        'burn_time_hours': 40,
        'wick_material': 'Cotton',
        'jar_material': 'Glass',
      },
      variations: [
        ProductVariation(
          id: 'var_candle_010_lavender',
          productId: 'prod_candle_010',
          status: ProductStatus.active,
          attributes: {'scent': 'Lavender Dreams'},
          imageUrls: [
            'https://picsum.photos/id/89/400/400',
            'https://picsum.photos/id/90/400/400',
            'https://picsum.photos/id/91/400/400',
            'https://picsum.photos/id/92/400/400',
          ],
          price: 22.00,
          stockQuantity: 60,
          storeId: 'store_zenoasis',
          storeName: 'Zen Oasis',
        ),
        ProductVariation(
          id: 'var_candle_010_sandalwood',
          productId: 'prod_candle_010',
          status: ProductStatus.active,
          attributes: {'scent': 'Warm Sandalwood'},
          imageUrls: [
            'https://picsum.photos/id/93/400/400',
            'https://picsum.photos/id/94/400/400',
            'https://picsum.photos/id/95/400/400',
            'https://picsum.photos/id/96/400/400',
          ],
          price: 22.00,
          stockQuantity: 40,
          storeId: 'store_zenoasis',
          storeName: 'Zen Oasis',
        ),
      ],
    ),
  ];

  Future<String> createNewProduct({
    required String name,
    required String description,
    required String subcategoryId,
    required String imageUrl,
    required Map<String, dynamic> specs,
  }) async {
    return await _products.createNewProduct(
      name: name,
      description: description,
      subcategoryId: subcategoryId,
      imageUrl: imageUrl,
      specs: specs,
    );
    // return await _connector
    //     .createNewProduct(
    //       name: name,
    //       description: description,
    //       category: subcategoryId,
    //       mainImage: imageUrl,
    //       specs: specs,
    //     )
    //     .execute()
    //     .then((result) {
    //       return result.data.listing_insert.id;
    //     });
  }

  Future<void> createNewProductVariation({
    required String productId,
    required List<String> imageUrls,
    required double price,
    required int availabeStock,
    required Map<String, dynamic> attributes,
    required String storeId,
  }) async {
    await _products.createNewProductVariation(
      productId: productId,
      imageUrls: imageUrls,
      price: price,
      availabeStock: availabeStock,
      attributes: attributes,
      storeId: storeId,
    );
    // await _connector
    //     .createNewProductVariation(
    //       storeId: storeId,
    //       attributes: attributes,
    //       productId: productId,
    //       imageUrls: imageUrls,
    //       price: price,
    //       availabeStock: availabeStock,
    //     )
    //     .execute();
  }

  Future<List<Product>> getAllProducts({
    String searchTerm = '',
    String? categoryId,
  }) async {
    return products;
    return await _products.getAllProducts(
      searchTerm: searchTerm,
      categoryId: categoryId,
    );

    // var query = _connector.getAllProducts();
    // // if (categoryId != null) query = query.categoryId(categoryId);

    // return await query.execute().then(
    //   (result) => result.data.products
    //       .map(
    //         (p) => Product(
    //           id: p.id,
    //           name: p.name,
    //           description: p.description,
    //           specifications: p.specifications.value as Map<String, dynamic>,
    //           variations: p.variations
    //               .map(
    //                 (v) => ProductVariation(
    //                   id: v.id,
    //                   attributes: v.attributes.value,
    //                   imageUrls: v.imageUrls,
    //                   price: v.price,
    //                   stockQuantity: v.availabeStock,
    //                 ),
    //               )
    //               .toList(),
    //         ),
    //       )
    //       .toList(),
    // );
  }

  Future<Product> getProductById(String id) async {
    return await _products.getProductById(id);
    // return await _connector.getProductById(id: id).execute().then((result) {
    //     final p = result.data.product;
    //     if (p == null) throw ('No product found');
    //     return Product(
    //       id: p.id,
    //       name: p.name,
    //       description: p.description,
    //       specifications: p.specifications.value as Map<String, dynamic>,
    //       variations: p.variations
    //           .map(
    //             (v) => ProductVariation(
    //               id: v.id,
    //               attributes: v.attributes.value,
    //               imageUrls: v.imageUrls,
    //               price: v.price,
    //               stockQuantity: v.availabeStock,
    //             ),
    //           )
    //           .toList(),
    //     );
    //   });
  }

  Future<ProductExtractionListingData> productExtractionListing(
    UserContent content,
  ) async {
    return _fn.productExtractionListing(content);
  }

  Future productSearch(UserContent userContentMedia) async {
    return await _fn.productSearch(userContentMedia);
  }
}
