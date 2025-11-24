class StoreMetricModel {
  final String storeId;
  final String storeName;

  final double totalNetPayoutAllTime;
  final double netPayoutEscrow;
  final int totalPendingItems;
  final int totalOutForDeliveryProxy;
  final int totalApprovedItems;
  final int totalRejectedItems;

  final int totalOffers;
  final int totalActiveOffers;

  final int totalProducts;

  final DateTime lastCalculatedAt;

  const StoreMetricModel({
    required this.storeId,
    required this.storeName,
    required this.netPayoutEscrow,
    required this.totalNetPayoutAllTime,
    required this.totalPendingItems,
    required this.totalOutForDeliveryProxy,
    required this.totalApprovedItems,
    required this.totalRejectedItems,
    required this.totalOffers,
    required this.totalActiveOffers,
    required this.totalProducts,
    required this.lastCalculatedAt,
  });

  factory StoreMetricModel.fromJson(Map<String, dynamic> json) {
    return StoreMetricModel(
      storeId: json['store_id'] as String,
      storeName: json['store_name'] as String,
      netPayoutEscrow: (json['expected_net_payout_escrow'] as num).toDouble(),
      totalNetPayoutAllTime: (json['net_payout_completed_all_time'] as num)
          .toDouble(),
      totalPendingItems: json['total_pending_items'] as int,
      totalOutForDeliveryProxy: json['total_out_for_delivery_proxy'] as int,
      totalApprovedItems: json['total_approved_items'] as int,
      totalRejectedItems: json['total_rejected_items'] as int,
      totalOffers: json['total_offers'] as int,
      totalActiveOffers: json['total_active_offers'] as int,
      totalProducts: json['total_products'] as int,
      lastCalculatedAt: DateTime.parse(json['last_calculated_at'] as String),
    );
  }
}
