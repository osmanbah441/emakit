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
  final String? displayName;
  final String? phoneNumber;
  final String? photoURL;
  final String? email;
  final bool emailVerified;
  final UserRole role;

  UserInfo({
    this.displayName,
    this.phoneNumber,
    this.email,
    this.emailVerified = false,
    this.photoURL,
    this.role = UserRole.buyer,
  });
}
