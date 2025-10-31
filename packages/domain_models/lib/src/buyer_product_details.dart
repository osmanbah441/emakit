import 'package:domain_models/domain_models.dart';

/// Product model tailored for the buyer's view, including options and ratings.
class BuyerProductDetails extends Product {
  final Map<String, List<String>> variationOptions;
  final double averageRating;
  final int reviewCount;
  final List<ProductVariation> variants;

  const BuyerProductDetails({
    required super.id,
    required super.name,
    required super.description,
    required this.variants,
    super.specifications,
    super.mainProductMedia,
    this.variationOptions = const {},
    this.averageRating = 0,
    this.reviewCount = 0,
    super.categoryId,
  });

  factory BuyerProductDetails.fromJson(Map<String, dynamic> json) {
    final mainMediaJson = json['media'] as List<dynamic>? ?? [];
    final mainProductMedia = mainMediaJson
        .map((mediaJson) => ProductMedia.fromJson(mediaJson))
        .toList();

    final variantsJson = json['variants'] as List<dynamic>? ?? [];
    final List<ProductVariation> variants = variantsJson
        .map(
          (variantJson) =>
              ProductVariation.fromJson(variantJson as Map<String, dynamic>),
        )
        .toList();

    final Map<String, List<String>> variationOptions = {};
    (json['options'] as Map<String, dynamic>?)?.forEach((key, value) {
      if (value is List) {
        variationOptions[key] = value.map((e) => e.toString()).toList();
      }
    });

    return BuyerProductDetails(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      specifications: json['specifications'] as Map<String, dynamic>? ?? {},
      mainProductMedia: mainProductMedia,
      variants: variants,
      variationOptions: variationOptions,
      averageRating: 0.0,
      reviewCount: 0,
    );
  }

  /// Extracts unique color options and their swatch images (from variant media).
  List<ColorOption> get colorOptions {
    const colorAttributeName = 'Color';
    final Map<String, ProductVariation> uniqueColors = {};

    for (final variant in variants) {
      final color = variant.attributes[colorAttributeName];
      // Ensure color is a non-empty string and not already added
      if (color != null &&
          color is String &&
          color.isNotEmpty &&
          !uniqueColors.containsKey(color)) {
        uniqueColors[color] = variant;
      }
    }

    return uniqueColors.entries.map((entry) {
      final colorName = entry.key;
      final variant = entry.value;

      final swatchUrl = variant.media.isNotEmpty
          ? variant.media.first.url
          : 'https://placehold.co/70x70/CCCCCC/000000?text=$colorName';

      return ColorOption(name: colorName, swatchImageUrl: swatchUrl);
    }).toList();
  }
}
