import 'dart:async';
import 'dart:typed_data';
import 'package:dataconnect/dataconnect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:functions/functions.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeLoading()) {
    _registerHandler();
    add(LoadProducts());
  }

  final _db = DataconnectService.instance;
  final _fn = MooemartFunctions.instance;

  void _registerHandler() async => on<HomeEvent>(
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
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    try {
      final fetchPage = await _db.fetchProducts(searchTerm: event.searchTerm);
      emit(
        HomeLoaded(products: fetchPage, currentSearchTerm: event.searchTerm),
      );
    } catch (e) {
      emit(HomeError(message: 'Failed to load products: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<HomeState> emit,
  ) async {
    add(LoadProducts());
  }

  Future<void> _onSendRecordingSearch(
    SendRecordingSearch event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeSearchProcessing());

    try {
      final res = await _fn.productSearch(
        MooemartMediaPart(event.bytes, event.mimeType),
      );

      emit(HomeSearchSuccess(result: res));
    } catch (e) {
      emit(HomeSearchError(message: 'Voice search failed: ${e.toString()}'));
    }
  }

  Future<void> _onSendTextSearch(
    SendTextSearch event,
    Emitter<HomeState> emit,
  ) async {
    if (event.text.isEmpty) return;
    emit(const HomeSearchProcessing());

    try {
      final res = await _fn.productSearch(MooemartTextPart(event.text));
      emit(HomeSearchSuccess(result: res));
    } catch (e) {
      emit(HomeSearchError(message: 'Text search failed: ${e.toString()}'));
    }
  }

  Future<void> _onToggleCartStatus(
    ToggleCartStatus event,
    Emitter<HomeState> emit,
  ) async {
    await _db.addToCart(event.product, 1);
  }

  Future<void> _onToggleWishlistStatus(
    ToggleWishlistStatus event,
    Emitter<HomeState> emit,
  ) async {
    await _db.toggleWishlistStatus(event.productId);
  }
}
