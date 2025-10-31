enum StoreStatus {
  pending,
  approved,
  rejected,
  suspended;

  static StoreStatus fromString(String status) => switch (status) {
    'approved' => StoreStatus.approved,
    'rejected' => StoreStatus.rejected,
    'suspended' => StoreStatus.suspended,
    _ => StoreStatus.pending,
  };

  bool get isPending => this == StoreStatus.pending;
  bool get isApproved => this == StoreStatus.approved;
  bool get isRejected => this == StoreStatus.rejected;
  bool get isSuspended => this == StoreStatus.suspended;
}

class Store {
  final String id;
  final String ownerId;
  final String name;
  final String? description;
  final String? logoUrl;
  final StoreStatus status;
  final bool isVerified;
  final List<String> phones;
  final List<String> emails;
  final double rating;
  final int reviewCount;

  const Store({
    required this.id,
    this.ownerId = '',
    required this.name,
    this.description,
    this.logoUrl,
    this.status = StoreStatus.pending,
    this.isVerified = false,
    this.phones = const [],
    this.emails = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
  });
}

class StoreOffer {
  final String id;
  final double price;
  final String storeId;
  final String storeName;
  final int stockQuantity;

  const StoreOffer({
    required this.id,
    required this.price,
    required this.storeId,
    required this.storeName,
    required this.stockQuantity,
  });

  factory StoreOffer.fromJson(Map<String, dynamic> json) {
    return StoreOffer(
      id: json['store_offer_id'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      storeId: json['store_id'] as String? ?? '',
      storeName: json['store_name'] as String? ?? '',
      stockQuantity: json['stock_quantity'] as int? ?? 0,
    );
  }
}
