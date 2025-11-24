import 'package:domain_models/domain_models.dart';

class StoreOrderItemFulfillment {
  final String storeId;
  final String storeName;
  final String orderHeaderId;
  final DateTime orderDate;
  final String overallOrderStatus;
  final String orderNote;
  final String buyerFullName;
  final String deliveryPhoneNumber;
  final String orderItemId;
  final OrderItemStatus orderItemStatus;
  final String variantId;
  final String productName;
  final String variantSignature;
  final int quantity;
  final double priceAtPurchase;
  final double itemSubtotal;
  final double itemDeliveryFee;
  final double commissionFee;
  final double netStorePayout;
  final String offerId;
  final double storeListedPrice;
  final String storeOfferCondition;
  final ProductMedia media;
  final String userId;

  const StoreOrderItemFulfillment({
    required this.storeId,
    required this.storeName,
    required this.orderHeaderId,
    required this.orderDate,
    required this.overallOrderStatus,
    required this.orderNote,
    required this.buyerFullName,
    required this.deliveryPhoneNumber,
    required this.orderItemId,
    required this.orderItemStatus,
    required this.variantId,
    required this.productName,
    required this.variantSignature,
    required this.quantity,
    required this.priceAtPurchase,
    required this.itemSubtotal,
    required this.itemDeliveryFee,
    required this.commissionFee,
    required this.netStorePayout,
    required this.offerId,
    required this.storeListedPrice,
    required this.storeOfferCondition,
    required this.media,
    required this.userId,
  });

  factory StoreOrderItemFulfillment.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is String) return double.tryParse(value) ?? 0.0;
      return (value as num).toDouble();
    }

    OrderItemStatus orderItemStatus = OrderItemStatus.fromString(
      (json['order_item_status'] as String?) ?? '',
    );

    final media = ProductMedia.fromJson(json['image'] as Map<String, dynamic>);

    return StoreOrderItemFulfillment(
      userId: json['user_id'] as String,
      storeId: json['store_id'] as String,
      storeName: json['store_name'] as String,
      orderHeaderId: json['order_header_id'] as String,
      orderItemId: json['order_item_id'] as String,
      offerId: json['offer_id'] as String,
      variantId: json['variant_id'] as String,
      orderDate: DateTime.parse(json['order_date'] as String),
      overallOrderStatus: (json['overall_order_status'] as String?) ?? '',
      orderNote: (json['order_note'] as String?) ?? '',
      buyerFullName: (json['buyer_full_name'] as String?) ?? '',
      deliveryPhoneNumber: (json['delivery_phone_number'] as String?) ?? '',
      orderItemStatus: orderItemStatus,
      productName: (json['product_name'] as String?) ?? '',
      variantSignature: (json['variant_signature'] as String?) ?? '',
      storeOfferCondition: (json['store_offer_condition'] as String?) ?? '',
      media: media,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      priceAtPurchase: parseDouble(json['price_at_purchase']),
      itemSubtotal: parseDouble(json['item_subtotal']),
      itemDeliveryFee: parseDouble(json['item_delivery_fee']),
      commissionFee: parseDouble(json['commission_fee']),
      netStorePayout: parseDouble(json['net_store_payout']),
      storeListedPrice: parseDouble(json['store_listed_price']),
    );
  }
}
