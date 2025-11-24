import 'package:domain_models/domain_models.dart';

class StoreProduct {
  final String? productId;
  final String? variantId;
  final String? offerId;
  final String? productName;
  final String? manufacturer;
  final Map<String, dynamic>? productSpecifications;
  final List<ProductMedia>? productMedia;
  final String? variantSignature;
  final Map<String, dynamic>? variantAttributes;
  final String? categoryId;
  final String? productStatus;
  final String? storeId;
  final double? offerPrice;
  final int? offerStockQuantity;
  final String? offerCondition;
  final bool? offerIsActive;

  StoreProduct({
    this.productId,
    this.variantId,
    this.offerId,
    this.productName,
    this.manufacturer,
    this.productSpecifications,
    this.productMedia,
    this.variantSignature,
    this.variantAttributes,
    this.categoryId,
    this.productStatus,
    this.storeId,
    this.offerPrice,
    this.offerStockQuantity,
    this.offerCondition,
    this.offerIsActive,
  });

  factory StoreProduct.fromJson(Map<String, dynamic> json) {
    // Helper to safely parse a list of nested objects
    final List<dynamic>? mediaJson = json['product_media'] as List<dynamic>?;
    final List<ProductMedia>? mediaList = mediaJson
        ?.map((e) => ProductMedia.fromJson(e as Map<String, dynamic>))
        .toList();

    // Safely parse numbers that might be int or double into double
    final num? priceNum = json['offer_price'] as num?;

    return StoreProduct(
      productId: json['product_id'] as String?,
      variantId: json['variant_id'] as String?,
      offerId: json['offer_id'] as String?,
      productName: json['product_name'] as String?,
      manufacturer: json['manufacturer'] as String?,
      productSpecifications:
          json['product_specifications'] as Map<String, dynamic>?,
      productMedia: mediaList,
      variantSignature: json['variant_signature'] as String?,
      variantAttributes: json['variant_attributes'] as Map<String, dynamic>?,
      categoryId: json['category_id'] as String?,
      productStatus: json['product_status'] as String?,
      storeId: json['store_id'] as String?,
      offerPrice: priceNum?.toDouble(),
      offerStockQuantity: json['offer_stock_quantity'] as int?,
      offerCondition: json['offer_condition'] as String?,
      offerIsActive: json['offer_is_active'] as bool?,
    );
  }
}
