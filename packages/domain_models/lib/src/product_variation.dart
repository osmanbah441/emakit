import 'package:domain_models/domain_models.dart';

class ProductVariation {
  final String id;
  final Map<String, dynamic> attributes; // e.g., {"color": "Blue", "size": "M"}
  final String variantSignature;
  final List<StoreOffer> offers; // Multiple offers from different stores
  final List<ProductMedia> media; // variant images

  const ProductVariation({
    required this.id,
    required this.attributes,
    required this.variantSignature,
    this.offers = const [],
    this.media = const [],
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    final List<dynamic> offersJson = json['offers'] as List<dynamic>? ?? [];
    final List<StoreOffer> offers = offersJson
        .map(
          (offerJson) => StoreOffer.fromJson(offerJson as Map<String, dynamic>),
        )
        .toList();

    final List<dynamic> mediaJson = json['media'] as List<dynamic>? ?? [];
    final List<ProductMedia> media = mediaJson
        .map(
          (mediaJson) =>
              ProductMedia.fromJson(mediaJson as Map<String, dynamic>),
        )
        .toList();

    return ProductVariation(
      id: json['id'] as String? ?? '',
      attributes: json['attributes'] as Map<String, dynamic>? ?? {},
      variantSignature: json['variant_signature'] as String? ?? '',
      offers: offers,
      media: media,
    );
  }
}
