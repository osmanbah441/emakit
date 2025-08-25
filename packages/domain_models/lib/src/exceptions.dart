/// Base class for all authentication-related exceptions.
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class InvalidPhoneNumberException extends AppException {
  const InvalidPhoneNumberException()
    : super('The phone number entered is invalid. Please check the format.');
}

class InvalidOtpException extends AppException {
  const InvalidOtpException()
    : super('The OTP you entered is incorrect. Please try again.');
}

class NetworkErrorException extends AppException {
  const NetworkErrorException()
    : super('A network error occurred. Please check your internet connection.');
}

class TooManyRequestsException extends AppException {
  const TooManyRequestsException()
    : super('Too many attempts. Please try again later.');
}

class UserDisabledException extends AppException {
  const UserDisabledException()
    : super('This account has been disabled. Contact support for help.');
}

class SessionExpiredException extends AppException {
  const SessionExpiredException()
    : super('The verification session has expired. Please request a new code.');
}

class GoogleSignInAbortedException extends AppException {
  const GoogleSignInAbortedException()
    : super('Google sign-in aborted by the user.');
}

class UnknownAuthException extends AppException {
  final String code;
  const UnknownAuthException(this.code, [String? message])
    : super(message ?? 'An unknown authentication error occurred.');
}

// TODO: remove all exception to use app exception

final class AudioPathNotFoundException implements Exception {
  const AudioPathNotFoundException([
    this.message = 'No path found for recorded audio.',
  ]);

  final String message;

  @override
  String toString() => message;
}

final class AudioReadException implements Exception {
  const AudioReadException([this.message = 'Failed to read recorded audio.']);

  final String message;

  @override
  String toString() => message;
}

final class AnalysisResponseException implements Exception {
  const AnalysisResponseException([this.message = 'Failed to analyze audio.']);

  final String message;

  @override
  String toString() => message;
}

class GenericAppException implements Exception {
  final String message;
  const GenericAppException(this.message);

  @override
  String toString() => message;
}

class UserAuthenticationRequiredException extends GenericAppException {
  const UserAuthenticationRequiredException()
    : super('User authentication required.');
}

class EmailAlreadyRegisteredException extends GenericAppException {
  const EmailAlreadyRegisteredException()
    : super('The email address is already in use by another account.');
}

class InvalidCredentialException extends GenericAppException {
  const InvalidCredentialException() : super('Invalid credentials.');
}

class EmptySearchResultException extends GenericAppException {
  const EmptySearchResultException() : super("No results found.");
}

class GoogleSignInCancelByUser extends GenericAppException {
  const GoogleSignInCancelByUser() : super('Google sign in cancelled');
}
