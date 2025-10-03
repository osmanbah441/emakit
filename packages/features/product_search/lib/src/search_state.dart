part of 'search_bloc.dart';

enum SearchStatus { idle, loading, success, failure }

class SearchState extends Equatable {
  final SearchStatus status;
  final String query;
  final List<Product> results;
  final String? error;

  const SearchState({
    this.status = SearchStatus.idle,
    this.query = '',
    this.results = const [],
    this.error,
  });

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<Product>? results,
    String? error,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      results: results ?? this.results,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, query, results, error];
}
