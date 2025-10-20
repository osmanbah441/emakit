import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:meta/meta.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class StoreProductListBloc
    extends Bloc<ProductListEvent, StoreProductListState> {
  StoreProductListBloc() : super(const ProductListLoading()) {
    _registerHandler();
    add(LoadProducts());
  }

  // final _api = DataConnect.instance;

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
    Emitter<StoreProductListState> emit,
  ) async {
    emit(const ProductListLoading());

    try {
      // final fetchPage = await _api.productRepository.getProductForStore(
      //   // searchTerm: event.searchTerm,
      // );

      // emit(
      //   ProductListLoaded(
      //     products: fetchPage,
      //     currentSearchTerm: event.searchTerm,
      //   ),
      // );
    } catch (e) {
      emit(
        ProductListError(message: 'Failed to load products: ${e.toString()}'),
      );
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<StoreProductListState> emit,
  ) async {
    add(LoadProducts());
  }

  Future<void> _onSendRecordingSearch(
    SendRecordingSearch event,
    Emitter<StoreProductListState> emit,
  ) async {
    emit(const ProductListSearchProcessing());

    try {
      // final res = await _api.productRepository.productSearch(
      //   UserContentMedia(event.bytes, event.mimeType),
      // );

      // emit(ProductListSearchSuccess(result: res));
    } catch (e) {
      emit(
        ProductListSearchError(message: 'Voice search failed: ${e.toString()}'),
      );
    }
  }

  Future<void> _onSendTextSearch(
    SendTextSearch event,
    Emitter<StoreProductListState> emit,
  ) async {
    if (event.text.isEmpty) return;
    emit(const ProductListSearchProcessing());

    try {
      // final res = await _api.productRepository.productSearch(
      //   UserContentText(event.text),
      // );
      // emit(ProductListSearchSuccess(result: res));
    } catch (e) {
      emit(
        ProductListSearchError(message: 'Text search failed: ${e.toString()}'),
      );
    }
  }

  Future<void> _onToggleCartStatus(
    ToggleCartStatus event,
    Emitter<StoreProductListState> emit,
  ) async {
    // await _api.userCommerceRepository.addToCart(event.product, 1);
  }

  Future<void> _onToggleWishlistStatus(
    ToggleWishlistStatus event,
    Emitter<StoreProductListState> emit,
  ) async {
    // await _api.userCommerceRepository.toggleWishlistStatus(event.productId);
  }
}
