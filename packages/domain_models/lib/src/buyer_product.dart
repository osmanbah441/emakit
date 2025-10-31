import 'package:domain_models/domain_models.dart';

class BuyerProductsList extends Product {
  const BuyerProductsList({
    required super.id,
    required super.name,
    required this.media,
    required this.variantId,
    this.price = 0.0,
    required super.description,
  });

  final double price;
  final ProductMedia media;
  final String variantId;

  factory BuyerProductsList.fromJson(Map<String, dynamic> json) {
    final mediaJson = json['primary_image'] as Map<String, dynamic>;
    final ProductMedia media = ProductMedia.fromJson(mediaJson);

    return BuyerProductsList(
      id: json['product_id'] as String,
      name: json['product_name'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num? ?? 0.0).toDouble(),
      variantId: json['variant_id'] as String,
      media: media,
    );
  }
}
