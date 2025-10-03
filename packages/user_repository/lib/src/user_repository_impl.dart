part of 'user_repository.dart';

// This compile-time constant is the key to our platform-specific logic.
const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Internal state for phone authentication
  ConfirmationResult? _confirmationResultWeb;
  String? _verificationIdMobile;
  bool _isGoogleSignInInitialized = false;

  // Stream controller to broadcast phone auth status updates.
  final _phoneAuthController = StreamController<PhoneAuthStatus>.broadcast();

  @override
  Stream<PhoneAuthStatus> get onPhoneAuthStatusChanged =>
      _phoneAuthController.stream;

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
  Future<void> signInWithPhoneNumber({required String phoneNumber}) async {
    try {
      if (kIsWeb) {
        _confirmationResultWeb = await _auth.signInWithPhoneNumber(phoneNumber);
        _phoneAuthController.add(PhoneAuthCodeSent());
      } else {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
            _phoneAuthController.add(PhoneAuthAutoVerified());
          },
          verificationFailed: (FirebaseAuthException e) {
            _phoneAuthController.add(PhoneAuthFailed(e.toDomainException));
          },
          codeSent: (String verificationId, int? resendToken) {
            _verificationIdMobile = verificationId;
            _phoneAuthController.add(PhoneAuthCodeSent());
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
    } on FirebaseAuthException catch (e) {
      _phoneAuthController.add(PhoneAuthFailed(e.toDomainException));
    }
  }

  @override
  Future<void> verifyPhoneNumberOtp({required String otpCode}) async {
    try {
      if (kIsWeb) {
        assert(
          _confirmationResultWeb != null,
          "On web, signInWithPhoneNumber must be called first.",
        );
        await _confirmationResultWeb!.confirm(otpCode);
      } else {
        // Mobile
        assert(
          _verificationIdMobile != null,
          "On mobile, signInWithPhoneNumber must be called first.",
        );
        final credential = PhoneAuthProvider.credential(
          verificationId: _verificationIdMobile!,
          smsCode: otpCode,
        );
        await _auth.signInWithCredential(credential);
      }
      _phoneAuthController.add(PhoneAuthSuccess());
    } on FirebaseAuthException catch (e) {
      _phoneAuthController.add(PhoneAuthFailed(e.toDomainException));
      throw e.toDomainException;
    }
  }

  @override
  Future<void> updateDisplayName({required String username}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("User not signed in.");
      await user.updateDisplayName(username);
    } on FirebaseAuthException catch (e) {
      throw e.toDomainException;
    }
  }

  @override
  Future<void> deleteUserAccount() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw e.toDomainException;
    }
  }

  @override
  Future<void> linkWithPhoneNumber({required String phoneNumber}) {
    // TODO: implement linkWithPhoneNumber
    throw UnimplementedError();
  }
}
