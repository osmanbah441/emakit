import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });
}

final List<Product> mockCatalog = [
  Product(
    id: "1",
    name: "Nike Running Shoes",
    category: "Shoes",
    price: 79.99,
    imageUrl: "https://picsum.photos/seed/shoes1/300/300",
  ),
  Product(
    id: "2",
    name: "Adidas Sneakers",
    category: "Shoes",
    price: 89.99,
    imageUrl: "https://picsum.photos/seed/shoes2/300/300",
  ),
  Product(
    id: "3",
    name: "Blue Denim Jacket",
    category: "Clothing",
    price: 59.99,
    imageUrl: "https://picsum.photos/seed/jacket/300/300",
  ),
  Product(
    id: "4",
    name: "Apple iPhone 14",
    category: "Electronics",
    price: 999.99,
    imageUrl: "https://picsum.photos/seed/iphone/300/300",
  ),
  Product(
    id: "5",
    name: "Samsung Galaxy S23",
    category: "Electronics",
    price: 899.99,
    imageUrl: "https://picsum.photos/seed/galaxy/300/300",
  ),
  Product(
    id: "6",
    name: "MacBook Pro 16",
    category: "Electronics",
    price: 2499.99,
    imageUrl: "https://picsum.photos/seed/macbook/300/300",
  ),
  Product(
    id: "7",
    name: "Sony Headphones",
    category: "Electronics",
    price: 199.99,
    imageUrl: "https://picsum.photos/seed/headphones/300/300",
  ),
];

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<SearchEvent>(
      (event, emit) async => switch (event) {
        SubmitTextSearch() => _onText(event, emit),
        SubmitImageSearch() => _onImage(event, emit),
        ClearSearch() => emit(const SearchState()),
      },
    );
  }

  Future<void> _onText(SubmitTextSearch e, Emitter<SearchState> emit) async {
    final q = e.query.trim();
    if (q.isEmpty) return;
    emit(
      state.copyWith(
        status: SearchStatus.loading,
        query: q,
        results: const [],
        error: null,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 400));

    final matches = mockCatalog
        .where((p) => p.name.toLowerCase().contains(q.toLowerCase()))
        .toList();
    emit(state.copyWith(status: SearchStatus.success, results: matches));
  }

  Future<void> _onImage(SubmitImageSearch e, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        status: SearchStatus.loading,
        results: const [],
        error: null,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 600));

    // Fake: map image → Electronics products
    final matches = mockCatalog
        .where((p) => p.category == "Electronics")
        .toList();
    emit(state.copyWith(status: SearchStatus.success, results: matches));
  }
}
