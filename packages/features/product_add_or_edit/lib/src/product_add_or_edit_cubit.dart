import 'package:category_repository/category_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_add_or_edit/src/product_add_or_edit_state.dart';
import 'package:product_repository/product_repository.dart';

class ProductAddOrEditCubit extends Cubit<ProductAddOrEditState> {
  ProductAddOrEditCubit({
    this.productIdToEdit,
    required ProductRepository productRepository,
    required CategoryRepository categoryRepository,
  }) : _productRepository = productRepository,
       _categoryRepository = categoryRepository,
       super(ProductAddOrEditLoading()) {
    _fetchInitialData(productIdToEdit);
  }

  final String? productIdToEdit;
  final ProductRepository _productRepository;
  final CategoryRepository _categoryRepository;

  Future<void> _fetchInitialData(String? id) async {
    // try {
    //   final categories = await _categoryRepository.productCategory();

    //   Product? product;
    //   if (id != null) {
    //     product = await _productRepository.getById(id);
    //   }

    //   Category? initialCategory = product != null
    //       ? categories.firstWhere(
    //           (c) => c.id == product?.categoryId,
    //           orElse: () => categories.first,
    //         )
    //       : null;

    //   emit(
    //     ProductAddOrEditSuccess(
    //       allCategories: categories,
    //       productToEdit: product,
    //       selectedCategory: initialCategory,
    //     ),
    //   );
    // } catch (e) {
    //   emit(ProductAddOrEditError('Failed to load data: ${e.toString()}'));
    // }
  }

  void onCategorySelected(Category? category) {
    if (state is ProductAddOrEditSuccess) {
      final current = state as ProductAddOrEditSuccess;
      emit(current.copyWith(selectedCategory: category));
    }
  }

  Future<void> upsertProduct({
    required String name,
    required String description,
    required Map<String, dynamic>? specs,
    required String categoryId,
    required List<ProductMedia> imageUrls,
  }) async {
    if (state is! ProductAddOrEditSuccess) return;
    final current = state as ProductAddOrEditSuccess;

    // set loading
    emit(
      current.copyWith(
        isLoading: true,
        errorMessage: null,
        saveCompleted: false,
      ),
    );

    try {
      await _productRepository.upsert(
        id: current.productToEdit?.id,
        name: name,
        description: description,
        specs: specs,
        categoryId: categoryId,
        imageUrls: imageUrls,
      );

      // success
      emit(
        current.copyWith(
          isLoading: false,
          errorMessage: null,
          saveCompleted: true,
        ),
      );

      // immediately reset saveCompleted so UI can rebuild cleanly next time
      emit(
        current.copyWith(
          isLoading: false,
          errorMessage: null,
          saveCompleted: false,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        current.copyWith(
          isLoading: false,
          errorMessage: 'Failed to save product: ${e.toString()}',
          saveCompleted: false,
        ),
      );
    }
  }
}
