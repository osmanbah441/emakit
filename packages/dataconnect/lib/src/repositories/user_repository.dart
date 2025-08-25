import 'package:domain_models/domain_models.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

import '../dataconnect_gen/default.dart';

extension on User {
  domain.UserInfo get toDomain => domain.UserInfo(
    email: email,
    displayName: displayName!,
    photoURL: photoURL,
    phoneNumber: phoneNumber,
  );
}

class UserRepository {
  const UserRepository();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static ConfirmationResult? _confirmationResult;
  domain.UserInfo? get currentUser => _auth.currentUser?.toDomain;

  static final _connector = DefaultConnector.instance;

  Future<domain.Store?> get getStore async =>
      await _connector.getUserStore().execute().then((result) {
        final data = result.data.user?.store;
        if (data == null) return null;

        return domain.Store(
          id: data.id,
          ownerId: '',
          description: data.description ?? '',
          logoUrl: data.logoUrl,

          name: data.name,
          status: domain.StoreStatus.fromString(data.status),
        );
      });

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
    await _connector.updateDisplayName(displayName: displayName).execute();
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
      final isNewUser = credential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        _connector
            .createNewUser()
            .phoneNumber(credential.user!.phoneNumber)
            .execute();
      }

      return isNewUser;
    }

    throw const domain.UserAuthenticationRequiredException();
  }

  Future<void> signInWithGoogleWeb() async {
    try {
      final authProvider = GoogleAuthProvider();
      final credential = await _auth.signInWithPopup(authProvider);
      final isNewUser = credential.additionalUserInfo?.isNewUser ?? false;
      final user = credential.user;
      if (user != null && isNewUser) {
        final fn = _connector.createNewUser();
        if (user.email != null) fn.email(user.email!);
        if (user.displayName != null) fn.displayName(user.displayName!);
        if (user.photoURL != null) fn.photoUrl(user.photoURL!);
        await fn.execute();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  Future<void> applyToBecomeSeller({
    required String businessName,
    required String phoneNumber,
  }) async {
    await _connector
        .applyForStore(name: businessName, phoneNumber: phoneNumber)
        .execute();
  }
}
