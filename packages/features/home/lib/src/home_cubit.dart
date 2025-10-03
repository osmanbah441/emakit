import 'package:category_repository/category_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_repository/store_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
    : _categoryRepository = CategoryRepository.instance,
      _storeRepository = StoreRepository.instance,
      super(const HomeState()) {
    fetchHomePageData();
  }

  final CategoryRepository _categoryRepository;
  final StoreRepository _storeRepository;

  Future<void> fetchHomePageData() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final data = await Future.wait([
        _categoryRepository.getTopLevelCategories(),
        _storeRepository.getAllStores(),
      ]);

      emit(
        state.copyWith(
          status: HomeStatus.success,
          productCategories: data[0] as List<ProductCategory>,
          featuredStores: data[1] as List<Store>,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void toggleFollow(String storeId) async {}
}
