import 'package:domain_models/domain_models.dart';

final class CartItem {
  final String id;
  final ProductVariation product;
  final int quantity;
  final String productName;
  final bool isSelected;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.productName,
    this.isSelected = false,
  });
}
