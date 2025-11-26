part of 'user_repository.dart';

const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

class UserRepositoryImpl implements UserRepository {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isGoogleSignInInitialized = false;

  final user = domain.UserInfo(displayName: 'osman', email: 'osmanBah441@gmail.com');

  @override
  Stream<domain.UserInfo?> get onUserChanges {
    // return _auth.userChanges().map((firebaseUser) => firebaseUser?.toDomain);
    return Stream.value(user);
  }

  @override
  domain.UserInfo? get currentUser {
    // return _auth.currentUser?.toDomain;
    return user;
  }

  @override
  Future<void> signOut() async {
    // try {
    //   await _auth.signOut();
    // } on FirebaseAuthException catch (e) {
    //   throw e.toDomainException;
    // }
  }

  @override
  Future<void> signInWithGoogle() async {
    // try {
    //   if (kIsWeb) {
    //     final authProvider = GoogleAuthProvider();
    //     await _auth.signInWithPopup(authProvider);
    //   } else {
    //     if (!_isGoogleSignInInitialized) {
    //       await GoogleSignIn.instance.initialize();
    //       _isGoogleSignInInitialized = true;
    //     }
    //     final googleUser = await GoogleSignIn.instance.authenticate();
    //     final googleAuth = googleUser.authentication;
    //     final credential = GoogleAuthProvider.credential(
    //       idToken: googleAuth.idToken,
    //     );
    //     await FirebaseAuth.instance.signInWithCredential(credential);
    //   }
    // } on FirebaseAuthException catch (e) {
    //   throw e.toDomainException;
    // }

    await Future.delayed(Duration(seconds: 2));

  }

  @override
  Future<void> signInWithApple() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
