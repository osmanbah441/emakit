enum UserRole {
  buyer,
  seller,
  admin;
  // Add other roles as needed, e.g., 'moderator'

  bool get isBuyer => this == UserRole.buyer;
  bool get isSeller => this == UserRole.seller;
  bool get isAdmin => this == UserRole.admin;
}

class UserInfo {
  final String name;
  final String phoneNumber;
  final String? profilePictureUrl;
  final UserRole role;

  UserInfo({
    required this.name,
    required this.phoneNumber,
    this.profilePictureUrl,
    this.role = UserRole.buyer,
  });
}
