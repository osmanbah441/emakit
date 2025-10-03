/// Base class for all authentication-related exceptions.
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

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

class EmptySearchResultException extends GenericAppException {
  const EmptySearchResultException() : super("No results found.");
}
