/// Base class for all authentication-related exceptions.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class InvalidPhoneNumberException extends AuthException {
  const InvalidPhoneNumberException()
    : super('The phone number entered is invalid. Please check the format.');
}

class InvalidOtpException extends AuthException {
  const InvalidOtpException()
    : super('The OTP you entered is incorrect. Please try again.');
}

class TooManyRequestsException extends AuthException {
  const TooManyRequestsException()
    : super('Too many attempts. Please try again later.');
}

class UserDisabledException extends AuthException {
  const UserDisabledException()
    : super('This account has been disabled. Contact support for help.');
}

class SessionExpiredException extends AuthException {
  const SessionExpiredException()
    : super('The verification session has expired. Please request a new code.');
}

class GoogleSignInAbortedException extends AuthException {
  const GoogleSignInAbortedException()
    : super('Google sign-in aborted by the user.');
}
