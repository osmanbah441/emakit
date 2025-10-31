import 'package:category_repository/category_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/buyer/buyer_home_state.dart';
import 'package:store_repository/store_repository.dart';

class BuyerHomeCubit extends Cubit<BuyerHomeState> {
  BuyerHomeCubit({
    required CategoryRepository categoryRepository,
    required StoreRepository storeRepository,
  }) : _categoryRepository = categoryRepository,
       _storeRepository = storeRepository,

       super(const BuyerHomeState()) {
    fetchData();
  }

  final CategoryRepository _categoryRepository;
  final StoreRepository _storeRepository;

  Future<void> fetchData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final allCategories = await _categoryRepository.getAll();
      final stores = await _storeRepository.getAllStores();

      final groupedCategories = <String, List<Category>>{};
      final parentNames = <String, String>{};

      for (var category in allCategories) {
        if (category.parentId == null && category.id != null) {
          parentNames[category.id!] = category.name;
          groupedCategories[category.name] = [];
        }
      }

      // 2. Assign children to their parents
      for (var category in allCategories) {
        if (category.parentId != null) {
          final parentName = parentNames[category.parentId];
          if (parentName != null) {
            groupedCategories[parentName]!.add(category);
          }
        }
      }

      // 3. Filter out parent categories that have no children
      final filteredCategories = Map.fromEntries(
        groupedCategories.entries.where((entry) => entry.value.isNotEmpty),
      );

      emit(
        state.copyWith(
          parentCategories: filteredCategories,
          featuredStores: stores,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to fetch data: $e'));
    }
  }
}
