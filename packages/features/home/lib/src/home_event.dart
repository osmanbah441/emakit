part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

class LoadProducts extends HomeEvent {
  final String searchTerm;

  const LoadProducts({this.searchTerm = ''});
}

class RefreshProducts extends HomeEvent {}

class SendRecordingSearch extends HomeEvent {
  const SendRecordingSearch({required this.bytes, required this.mimeType});

  final Uint8List bytes;
  final String mimeType;
}

class SendTextSearch extends HomeEvent {
  const SendTextSearch(this.text);

  final String text;
}

class ToggleCartStatus extends HomeEvent {
  final ProductVariation product;

  const ToggleCartStatus(this.product);
}

class ToggleWishlistStatus extends HomeEvent {
  final String productId;

  const ToggleWishlistStatus(this.productId);
}
