import 'package:domain_models/domain_models.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

extension on User {
  domain.UserInfo get toDomain => domain.UserInfo(
    email: email,
    displayName: displayName!,
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

  Stream<domain.UserInfo?> authChanges() {
    return _auth.authStateChanges().map((a) => a?.toDomain);
  }

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

  // return true if new user else false
  Future<bool> verifyOtp(String code) async {
    if (_confirmationResult != null) {
      final credential = await _confirmationResult!.confirm(code);

      return credential.additionalUserInfo?.isNewUser ?? false;
    }

    throw const domain.UserAuthenticationRequiredException();
  }

  Future<void> signInWithGoogleWeb() async {
    try {
      final authProvider = GoogleAuthProvider();
      await _auth.signInWithPopup(authProvider);

      // add this credentails to the db;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> signOut() async => await _auth.signOut();
}
