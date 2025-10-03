import 'package:domain_models/domain_models.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserToDomainUserInfo on User {
  domain.UserInfo get toDomain => domain.UserInfo(
    email: email,
    displayName: displayName,
    photoURL: photoURL,
    phoneNumber: phoneNumber,
  );
}

extension FirebaseAuthExceptionToDomainException on FirebaseAuthException {
  domain.AuthException get toDomainException {
    switch (code) {
      case 'invalid-phone-number':
        return const domain.InvalidPhoneNumberException();
      case 'invalid-verification-code':
        return const domain.InvalidOtpException();
      case 'too-many-requests':
        return const domain.TooManyRequestsException();
      case 'user-disabled':
        return const domain.UserDisabledException();
      case 'session-expired':
        return const domain.SessionExpiredException();
      case 'popup-closed-by-user':
      case 'cancelled': // For mobile
        return const domain.GoogleSignInAbortedException();
      default:
        return domain.AuthException(message ?? 'something when wrong');
    }
  }
}
