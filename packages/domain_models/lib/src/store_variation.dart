import 'package:domain_models/domain_models.dart';

@Deprecated('stop using now let focus on mutiple seller')
class StoreVariation {
  final String id;
  final Map<String, dynamic> attributes;
  final String variantSignature;
  final double price;
  final int stockQuantity;
  final Store store;
  final List<ProductMedia> media; // variant or seller images

  const StoreVariation({
    required this.id,
    required this.attributes,
    required this.variantSignature,
    required this.price,
    required this.stockQuantity,
    required this.store,
    this.media = const [],
  });
}
