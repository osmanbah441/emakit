import 'package:dataconnect/dataconnect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain_models/domain_models.dart';

// import 'package:collection/collection.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _searchTermController = PublishSubject<String>();

  final _db = DataconnectService.instance;
  // Initialize Cubit with HomeLoading state to immediately show a loading indicator
  HomeCubit() : super(HomeLoading()) {
    _searchTermController
        .debounceTime(
          const Duration(milliseconds: 500),
        ) // Wait for 500ms of inactivity
        .distinct() // Only proceed if the term is different from the last one
        .listen((searchTerm) {
          _fetchProducts(searchTerm: searchTerm);
        });

    // Perform an initial load of all products
    _fetchProducts();
  }

  void onSearchTermChanged(String term) {
    _searchTermController.add(term);
  }

  void updateWithSearchResult(String result) {
    // You could parse the result and update the product list
    // For now, we’ll just simulate it
    // emit(HomeLoaded([], currentSearchTerm: result));
  }

  void refreshProducts() {
    _fetchProducts();
  }

  Future<void> _fetchProducts({String searchTerm = ''}) async {
    // Only emit loading if the current state isn't already loading
    if (state is! HomeLoading) {
      emit(HomeLoading());
    }

    try {
      final fetchPage = await _db.fetchProducts(searchTerm: searchTerm);

      // TODO: add pagination

      emit(HomeLoaded(fetchPage, currentSearchTerm: searchTerm));
    } catch (e) {
      emit(HomeError('Failed to load products: ${e.toString()}'));
    }
  }

  // --- Cart Management ---
  void toggleCartStatus(ProductVariation product) async {
    // TODO: toggle if in cart then remove
    await _db.addToCart(product, 1);
  }

  // --- Wishlist Management ---
  void toggleWishlistStatus(String productId) async {
    await _db.toggleWishlistStatus(productId);
  }

  @override
  Future<void> close() {
    _searchTermController.close();
    return super.close();
  }
}
