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
