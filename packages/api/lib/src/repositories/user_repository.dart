import 'package:domain_models/domain_models.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

extension on User {
  domain.UserInfo get toDomain => domain.UserInfo(
    email: email,
    displayName: displayName,
    photoURL: photoURL,
    emailVerified: emailVerified,
    phoneNumber: phoneNumber,
  );
}

class UserRepository {
  const UserRepository();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static ConfirmationResult? _confirmationResult;
  domain.UserInfo? get currentUser => _auth.currentUser?.toDomain;

  Future<void> updateDisplayName(String displayName) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const domain.UserAuthenticationRequiredException();
    }

    await user.updateDisplayName(displayName);
    await user.reload();
  }

  Future<void> signInwithPhoneNumberWeb(String phoneNumber) async {
    try {
      _confirmationResult = await _auth.signInWithPhoneNumber(phoneNumber);
    } catch (_) {
      rethrow;
    }
  }

  Future<domain.AuthResult> verifyOtp(String code) async {
    if (_confirmationResult != null) {
      final credential = await _confirmationResult!.confirm(code);

      return domain.AuthResult(
        user: credential.user!.toDomain,
        isNewUser: credential.additionalUserInfo?.isNewUser ?? false,
      );
    }

    throw const domain.UserAuthenticationRequiredException();
  }

  Future<domain.AuthResult> signInWithGoogleWeb() async {
    try {
      final authProvider = GoogleAuthProvider();
      final credential = await _auth.signInWithPopup(authProvider);

      return domain.AuthResult(
        user: credential.user!.toDomain,
        isNewUser: credential.additionalUserInfo?.isNewUser ?? false,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  Future<domain.UserRole?> get getCurrentUserRole async {
    // return null;
    return domain.UserRole.admin;
  }
}
