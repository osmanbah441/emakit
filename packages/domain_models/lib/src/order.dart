import '../domain_models.dart';
import 'utils.dart';

class Order {
  final String id;
  final String userId;
  final DateTime createdAt;
  final List<OrderItem> items;
  final OrderStatus status;
  final double totalAmountPaid;

  Order({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.items,
    required this.totalAmountPaid,
    this.status = OrderStatus.pending,
  });

  String get formattedCreateAt => getFormattedDate(createdAt);

  int get totalItemsCount => items.length;

  int get completedItemsCount => items
      .where(
        (item) =>
            item.status == OrderItemStatus.rejected ||
            item.status == OrderItemStatus.approved,
      )
      .length;
}

enum OrderStatus {
  pending('pending'),
  preparingDelivery('preparing_delivery'),
  partiallyDelivered('partially_delivered'),
  confirmedDelivered('confirmed_delivered'),
  cancelled('cancelled');

  final String value;
  const OrderStatus(this.value);

  static OrderStatus fromString(String statusString) {
    return OrderStatus.values.firstWhere(
      (status) => status.value == statusString,
      orElse: () =>
          throw ArgumentError('Invalid order status string: $statusString'),
    );
  }
}

enum OrderItemStatus {
  pending('pending'),
  approved('delivered_confirmed'),
  outForDelivery('preparing_delivery'),
  rejected('cancelled');

  final String value;
  const OrderItemStatus(this.value);

  static OrderItemStatus fromString(String statusString) {
    return OrderItemStatus.values.firstWhere(
      (status) => status.value == statusString,
      orElse: () =>
          throw ArgumentError('Invalid item status string: $statusString'),
    );
  }
}

class OrderItem {
  final String itemId;
  final String offerId;
  final int quantity;
  final String storeId;
  final DateTime createdAt;
  final String productId;
  final OrderItemStatus status;
  final double deliveryFee;
  final String productName;
  final double itemSubtotal;
  final double commissionFee;
  final double netStorePayout;
  final double priceAtPurchase;
  final String variantSignature;
  final List<ProductMedia> media;

  OrderItem({
    required this.itemId,
    required this.offerId,
    required this.quantity,
    required this.storeId,
    required this.createdAt,
    required this.productId,
    required this.status,
    required this.deliveryFee,
    required this.productName,
    required this.itemSubtotal,
    required this.commissionFee,
    required this.netStorePayout,
    required this.priceAtPurchase,
    required this.variantSignature,
    required this.media,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    final List<dynamic> mediaJson =
        json['variant_media'] as List<dynamic>? ?? [];
    final List<ProductMedia> media = mediaJson
        .map(
          (mediaJson) =>
              ProductMedia.fromJson(mediaJson as Map<String, dynamic>),
        )
        .toList();
    return OrderItem(
      itemId: json['item_id'] as String,
      offerId: json['offer_id'] as String,
      quantity: json['quantity'] as int,
      storeId: json['store_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      productId: json['product_id'] as String,
      status: OrderItemStatus.fromString(json['item_status'] as String),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
      productName: json['product_name'] as String,
      itemSubtotal: (json['item_subtotal'] as num).toDouble(),
      commissionFee: (json['commission_fee'] as num).toDouble(),
      netStorePayout: (json['net_store_payout'] as num).toDouble(),
      priceAtPurchase: (json['price_at_purchase'] as num).toDouble(),
      variantSignature: json['variant_signature'] as String,
      media: media,
    );
  }

  @override
  String toString() {
    return 'OrderItem(id: $itemId, product: $productName, status: ${status.value})';
  }
}

class BuyerOrder extends Order {
  final String? escrowTransactionId;
  final String userPhoneNumber;
  final String note;
  final DateTime? updatedAt;

  BuyerOrder({
    required super.id,
    required super.totalAmountPaid,
    required super.userId,
    required super.status,
    this.escrowTransactionId,
    required this.userPhoneNumber,
    required this.note,
    this.updatedAt,
    required super.createdAt,
    required super.items,
  });

  factory BuyerOrder.fromJson(Map<String, dynamic> json) {
    final List<OrderItem> items = (json['order_items'] as List)
        .map((itemJson) => OrderItem.fromJson(itemJson as Map<String, dynamic>))
        .toList();

    return BuyerOrder(
      id: json['order_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      userId: json['user_id'] as String,
      status: OrderStatus.fromString(json['order_status'] as String),
      totalAmountPaid: (json['total_amount_paid'] as num).toDouble(),
      escrowTransactionId: json['escrow_transaction_id'] as String?,
      userPhoneNumber: json['user_phone_number'] as String,
      note: json['note'] as String,
      items: items,
    );
  }

  @override
  String toString() {
    return 'BuyerOrder(id: $id, status: ${status.value}, items: ${items.length})';
  }
}
