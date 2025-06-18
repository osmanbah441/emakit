import 'dart:async';
import 'package:ai_integration/ai_integration.dart';
import 'package:dataconnect/dataconnect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _db = DataconnectService.instance;

  final _audioAnalysis = AiIntegration.instance.audioAnalysisAI();

  Stream<({double current, double max})> get getAmplitudeStream =>
      _audioAnalysis.getamplitudeStream;

  HomeBloc() : super(const HomeLoading()) {
    _registerHandler();
    add(LoadProducts());
  }

  void _registerHandler() async => on<HomeEvent>(
    (event, emit) async => switch (event) {
      LoadProducts() => _onLoadProducts(event, emit),
      RefreshProducts() => _onRefreshProducts(event, emit),
      SearchTermChanged() => _onSearchTermChanged(event, emit),
      StartRecordingSearch() => _onStartRecordingSearch(event, emit),
      CancelRecordingSearch() => _onCancelRecordingSearch(event, emit),
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

  void _onSearchTermChanged(SearchTermChanged event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final newState = currentState.copyWith(currentSearchTerm: event.term);
      emit(newState);
    }
  }

  Future<void> _onStartRecordingSearch(
    StartRecordingSearch event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _audioAnalysis.startRecording();
    } catch (e) {
      emit(HomeSearchError(message: 'Recording start failed: ${e.toString()}'));
    }
  }

  Future<void> _onCancelRecordingSearch(
    CancelRecordingSearch event,
    Emitter<HomeState> emit,
  ) async {
    await _audioAnalysis.cancelRecording();
  }

  Future<void> _onSendRecordingSearch(
    SendRecordingSearch event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeSearchProcessing());

    try {
      final response = await _audioAnalysis.sendRecording();
      emit(HomeSearchSuccess(result: response));
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

    final textAnalysis = AiIntegration.instance.textAnalysis(event.text);

    try {
      final res = await textAnalysis.sendText(event.text);
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

  @override
  Future<void> close() {
    _audioAnalysis.dispose();
    return super.close();
  }
}
