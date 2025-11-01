class CartItem {
  final String id;
  final int quantity;
  final double unitPrice;
  final int availableStock;
  final double lineTotal;
  final String productName;
  final String variantSignature;
  final String imageUrl;
  final bool inStock;
  final bool isSelected;
  final String? productId;
  final String? storeOfferId;
  final String? variantId;

  const CartItem({
    required this.id,
    required this.quantity,
    required this.productName,
    required this.imageUrl,
    this.availableStock = 0,
    this.unitPrice = 0.0,
    this.lineTotal = 0.0,
    this.variantSignature = '',
    this.inStock = false,
    this.isSelected = false,
    this.storeOfferId,
    this.productId,
    this.variantId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return CartItem(
      id: json['cart_item_id'] as String,
      quantity: json['cart_quantity'] as int,
      storeOfferId: json['store_offer_id'] as String,
      unitPrice: parseDouble(json['unit_price']),
      availableStock: json['available_stock'] as int,
      lineTotal: parseDouble(json['line_total']),
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      variantId: json['variant_id'] as String,
      variantSignature: json['variant_signature'] as String,
      imageUrl: json['variant_image_url'] as String,
      inStock: json['in_stock'] as bool,
      isSelected: json['is_selected'] as bool,
    );
  }
}
