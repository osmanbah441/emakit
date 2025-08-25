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
  final String description;
  final String? logoUrl;
  final StoreStatus status;
  final bool isVerified;
  final List<String> phones;
  final List<String> emails;

  const Store({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    this.logoUrl,
    required this.status,
    this.isVerified = false,
    this.phones = const [],
    this.emails = const [],
  });
}
