part of 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static ConfirmationResult? _confirmationResultForWeb;

  @override
  Stream<domain.UserInfo?> get onAuthStateChanged {
    return _auth.authStateChanges().map((firebaseUser) {
      return firebaseUser?.toDomain;
    });
  }

  @override
  domain.UserInfo? get currentUser {
    final user = _auth.currentUser;
    return user?.toDomain;
  }

  @override
  Future<void> signInwithPhoneNumberWeb(String phoneNumber) async {
    try {
      _confirmationResultForWeb = await _auth.signInWithPhoneNumber(
        phoneNumber,
      );
    } on FirebaseAuthException catch (e) {
      throw e.toDomainException;
    }
  }

  @override
  Future<void> verifyOtpWeb(String code) async {
    try {
      final credential = await _confirmationResultForWeb!.confirm(code);
    } on FirebaseAuthException catch (e) {
      throw e.toDomainException;
    }
  }

  @override
  Future<void> signInWithGoogleWeb() async {
    try {
      final authProvider = GoogleAuthProvider();
      final credential = await _auth.signInWithPopup(authProvider);
    } on FirebaseAuthException catch (e) {
      throw e.toDomainException;
    }
  }

  @override
  Future<void> signInWithGoogleMobile() async {
    try {
      final googleUser = await GoogleSignIn.instance.authenticate();
      final credential = await _auth.signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: googleUser.authentication.idToken,
        ),
      );
    } on FirebaseAuthException catch (e) {
      throw e.toDomainException;
    }
  }

  @override
  Future<bool> signInWithPhoneNumberMobile() async {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.toDomainException;
    }
  }

  @override
  Future<void> completeUserProfileSetup({
    String? fullName,
    DateTime? dateOfBirth,
  }) async {
    final currentUser = _auth.currentUser!;
    if (fullName != null) await currentUser.updateDisplayName(fullName);

    await currentUser.reload();
  }

  @override
  Future<void> deleteUserAccount(String uid) async {
    throw UnimplementedError();
  }
}
