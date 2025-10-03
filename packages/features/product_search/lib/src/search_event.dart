part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class SubmitTextSearch extends SearchEvent {
  final String query;
  const SubmitTextSearch(this.query);
  @override
  List<Object?> get props => [query];
}

class SubmitImageSearch extends SearchEvent {
  final File image;
  const SubmitImageSearch(this.image);
  @override
  List<Object?> get props => [image.path];
}

class ClearSearch extends SearchEvent {}
