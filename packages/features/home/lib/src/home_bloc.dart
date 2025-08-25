import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_repository/product_repository.dart';

// Note: You will need to import your product_repository.dart file here.
// import 'path/to/your/product_repository.dart';
// And your product model
// import 'path/to/your/product_model.dart';

// =================================================================
// BLOC EVENT
// =================================================================

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

/// Event to fetch all initial data for the home screen sections.
class HomePageDataFetched extends HomeEvent {}

// =================================================================
// BLOC STATE
// =================================================================

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.productSections = const {},
    this.errorMessage = '',
  });

  final HomeStatus status;
  final Map<String, List<Product>> productSections;
  final String errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    Map<String, List<Product>>? productSections,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      productSections: productSections ?? this.productSections,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, productSections, errorMessage];
}

// =================================================================
// HOME BLOC
// =================================================================

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository _productRepository;

  HomeBloc({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(const HomeState()) {
    on<HomePageDataFetched>(_onHomePageDataFetched);
  }

  /// Handles fetching all categorized product lists for the home screen.
  Future<void> _onHomePageDataFetched(
    HomePageDataFetched event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final sections = await _productRepository.getProductsForAllCateggeories();
      emit(
        state.copyWith(status: HomeStatus.success, productSections: sections),
      );
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
