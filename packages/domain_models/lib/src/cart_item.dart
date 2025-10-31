class CartItem {
  final String id;
  final String userId;
  final int quantity;
  final String storeOfferId;
  final String storeId;
  final double unitPrice;
  final int availableStock;
  final double lineTotal;
  final String productId;
  final String productName;
  final String variantId;
  final String variantSignature;
  final Map<String, dynamic> variantAttributes;
  final String variantImageUrl;
  final bool inStock;
  final String availability;
  final bool isSelected;

  CartItem({
    required this.id,
    required this.userId,
    required this.quantity,
    required this.storeOfferId,
    required this.storeId,
    required this.unitPrice,
    required this.availableStock,
    required this.lineTotal,
    required this.productId,
    required this.productName,
    required this.variantId,
    required this.variantSignature,
    required this.variantAttributes,
    required this.variantImageUrl,
    required this.inStock,
    required this.availability,
    required this.isSelected,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return CartItem(
      id: json['cart_item_id'] as String,
      userId: json['user_id'] as String,
      quantity: json['cart_quantity'] as int,
      storeOfferId: json['store_offer_id'] as String,
      storeId: json['store_id'] as String,
      unitPrice: parseDouble(json['unit_price']),
      availableStock: json['available_stock'] as int,
      lineTotal: parseDouble(json['line_total']),
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      variantId: json['variant_id'] as String,
      variantSignature: json['variant_signature'] as String,
      variantAttributes: json['variant_attributes'] as Map<String, dynamic>,
      variantImageUrl: json['variant_image_url'] as String,
      inStock: json['in_stock'] as bool,
      availability: json['availability'] as String,
      isSelected: json['is_selected'] as bool,
    );
  }
}
