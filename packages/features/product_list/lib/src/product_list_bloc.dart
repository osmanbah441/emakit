import 'dart:async';
import 'dart:typed_data';
import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:meta/meta.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(const ProductListLoading()) {
    _registerHandler();
    add(LoadProducts());
  }

  final _api = Api.instance;

  void _registerHandler() async => on<ProductListEvent>(
    (event, emit) async => switch (event) {
      LoadProducts() => _onLoadProducts(event, emit),
      RefreshProducts() => _onRefreshProducts(event, emit),
      SendRecordingSearch() => _onSendRecordingSearch(event, emit),
      SendTextSearch() => _onSendTextSearch(event, emit),
      ToggleCartStatus() => _onToggleCartStatus(event, emit),
      ToggleWishlistStatus() => _onToggleWishlistStatus(event, emit),
    },
  );

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductListState> emit,
  ) async {
    emit(const ProductListLoading());

    try {
      final fetchPage = await _api.productRepository.getAllProducts(
        searchTerm: event.searchTerm,
      );

      emit(
        ProductListLoaded(
          products: fetchPage,
          currentSearchTerm: event.searchTerm,
        ),
      );
    } catch (e) {
      emit(
        ProductListError(message: 'Failed to load products: ${e.toString()}'),
      );
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductListState> emit,
  ) async {
    add(LoadProducts());
  }

  Future<void> _onSendRecordingSearch(
    SendRecordingSearch event,
    Emitter<ProductListState> emit,
  ) async {
    // Capture the current state *before* processing search
    final currentState = state;
    if (currentState is! ProductListLoaded) {
      // If we're not in a loaded state (e.g., initial loading error),
      // there's no previous product list to fall back to.
      emit(ProductListError(message: 'Cannot search from current state.'));
      return;
    }

    emit(const ProductListSearchProcessing());

    try {
      // --- FOR TESTING: Intentionally throw an error here ---
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay
      throw Exception('Internal server error');
      // --- END FOR TESTING ---

      // Original code (uncomment when you want real search):
      // final res = await _api.productRepository.productSearch(
      //   UserContentMedia(event.bytes, event.mimeType),
      // );
      // emit(ProductListSearchSuccess(result: res));
    } catch (e) {
      final errorMessage = e.toString();

      // 1. Emit the error state to trigger the dialog in the listener
      emit(ProductListSearchError(message: errorMessage));

      // 2. Immediately revert to the previous ProductListLoaded state
      //    This keeps the products on screen and also provides the error message
      //    to the ProductListLoaded state for potential inline display if needed.
      emit(
        currentState.copyWith(
          searchErrorMessage: errorMessage,
          searchInputMode: SearchInputMode.idle, // Reset search input mode
        ),
      );
    }
  }

  Future<void> _onSendTextSearch(
    SendTextSearch event,
    Emitter<ProductListState> emit,
  ) async {
    if (event.text.isEmpty) return;

    // Capture the current state *before* processing search
    final currentState = state;
    if (currentState is! ProductListLoaded) {
      // If we're not in a loaded state, there's no previous product list to fall back to.
      emit(ProductListError(message: 'Cannot search from current state.'));
      return;
    }

    emit(const ProductListSearchProcessing());

    try {
      // --- FOR TESTING: Intentionally throw an error here ---
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay
      throw Exception('Internal server error');
      // --- END FOR TESTING ---

      // Original code (uncomment when you want real search):
      // final res = await _api.productRepository.productSearch(
      //   UserContentText(event.text),
      // );
      // emit(ProductListSearchSuccess(result: res));
    } catch (e) {
      final errorMessage = e.toString();

      // 1. Emit the error state to trigger the dialog in the listener
      emit(ProductListSearchError(message: errorMessage));

      // 2. Immediately revert to the previous ProductListLoaded state
      //    This keeps the products on screen and also provides the error message
      //    to the ProductListLoaded state for potential inline display if needed.
      emit(
        currentState.copyWith(
          searchErrorMessage: errorMessage,
          searchInputMode: SearchInputMode.idle, // Reset search input mode
        ),
      );
    }
  }

  Future<void> _onToggleCartStatus(
    ToggleCartStatus event,
    Emitter<ProductListState> emit,
  ) async {
    await _api.userCommerceRepository.addToCart(event.product, 1);
  }

  Future<void> _onToggleWishlistStatus(
    ToggleWishlistStatus event,
    Emitter<ProductListState> emit,
  ) async {
    await _api.userCommerceRepository.toggleWishlistStatus(event.productId);
  }
}
