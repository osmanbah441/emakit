class UserInfo {
  final String displayName;
  final String? phoneNumber;
  final String? photoURL;
  final String? email;
  final bool emailVerified;

  UserInfo({
    required this.displayName,
    this.phoneNumber,
    this.email,
    this.emailVerified = false,
    this.photoURL,
  });
}

enum StoreStatus {
  pending,
  active,
  suspended,
  closed;

  static StoreStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return StoreStatus.pending;
      case 'active':
        return StoreStatus.active;
      case 'suspended':
        return StoreStatus.suspended;
      case 'closed':
        return StoreStatus.closed;
      default:
        throw ArgumentError('Invalid StoreStatus: $value');
    }
  }

  bool get isPending => this == StoreStatus.pending;
  bool get isActive => this == StoreStatus.active;
  bool get isSuspended => this == StoreStatus.suspended;
  bool get isClosed => this == StoreStatus.closed;
}

class Store {
  final String name;
  final String? description;
  final String? logoUrl;
  final String phoneNumber;
  final StoreStatus status;

  Store({
    required this.name,
    this.description,
    this.logoUrl,
    required this.phoneNumber,
    required this.status,
  });
}
