part of 'product_list_bloc.dart';

@immutable
sealed class ProductListEvent {
  const ProductListEvent();
}

class LoadProducts extends ProductListEvent {
  final String searchTerm;

  const LoadProducts({this.searchTerm = ''});
}

class RefreshProducts extends ProductListEvent {}

class SendRecordingSearch extends ProductListEvent {
  const SendRecordingSearch({required this.bytes, required this.mimeType});

  final Uint8List bytes;
  final String mimeType;
}

class SendTextSearch extends ProductListEvent {
  const SendTextSearch(this.text);

  final String text;
}

class ToggleCartStatus extends ProductListEvent {
  final ProductVariation product;

  const ToggleCartStatus(this.product);
}

class ToggleWishlistStatus extends ProductListEvent {
  final String productId;

  const ToggleWishlistStatus(this.productId);
}
