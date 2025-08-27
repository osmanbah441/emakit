import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_repository/product_repository.dart';
import 'package:category_repository/category_repository.dart';

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
    this.errorMessage = '',
    this.productCategories = const [],
  });

  final HomeStatus status;
  final String errorMessage;
  final List<ProductCategory> productCategories;

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<ProductCategory>? productCategories,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      productCategories: productCategories ?? this.productCategories,
    );
  }

  @override
  List<Object> get props => [status, productCategories, errorMessage];
}

// =================================================================
// HOME BLOC
// =================================================================

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
    : _categoryRepository = CategoryRepository.instance,
      super(const HomeState()) {
    on<HomePageDataFetched>(_onHomePageDataFetched);
  }

  final CategoryRepository _categoryRepository;

  /// Handles fetching all categorized product lists for the home screen.
  Future<void> _onHomePageDataFetched(
    HomePageDataFetched event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final fetchCategories = await _categoryRepository.getTopLevelCategories();
      emit(
        state.copyWith(
          status: HomeStatus.success,
          productCategories: fetchCategories,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
