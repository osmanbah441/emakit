import 'package:domain_models/domain_models.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

import '../default_connector/default.dart';

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
  static final _db = DefaultConnector.instance;

  domain.UserInfo? get currentUser => _auth.currentUser?.toDomain;

  Future<void> updateDisplayName(String displayName) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const domain.UserAuthenticationRequiredException();
    }

    await user.updateDisplayName(displayName);
    await user.reload();
  }

  Future<void> signInWithGoogleWeb() async {
    try {
      final authProvider = GoogleAuthProvider();
      final credentials = await _auth.signInWithPopup(authProvider);
      final user = credentials.user;
      if (user == null) return;
      final fn = _db.createNewUser(id: user.uid);
      if (user.email != null) fn.email(user.email!);
      if (user.displayName != null) fn.displayName(user.displayName!);
      if (user.photoURL != null) fn.photoURL(user.photoURL!);
      await fn.execute();
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
