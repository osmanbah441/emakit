part of 'user_repository.dart';

const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isGoogleSignInInitialized = false;

  @override
  Stream<domain.UserInfo?> get onUserChanges =>
      _auth.userChanges().map((firebaseUser) => firebaseUser?.toDomain);

  @override
  domain.UserInfo? get currentUser => _auth.currentUser?.toDomain;

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.toDomainException;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final authProvider = GoogleAuthProvider();
        await _auth.signInWithPopup(authProvider);
      } else {
        if (!_isGoogleSignInInitialized) {
          await GoogleSignIn.instance.initialize();
          _isGoogleSignInInitialized = true;
        }
        final googleUser = await GoogleSignIn.instance.authenticate();
        final googleAuth = googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      throw e.toDomainException;
    }
  }

  @override
  Future<void> signInWithApple() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
