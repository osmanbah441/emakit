part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchIdle extends SearchState {
  final String? searchResult;
  SearchIdle({this.searchResult});
}

class SearchTyping extends SearchState {}

class SearchRecording extends SearchState {}

class SearchProcessing extends SearchState {}

class SearchSuccess extends SearchState {
  final String result;
  SearchSuccess(this.result);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
