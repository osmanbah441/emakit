import 'dart:async';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_management_state.dart';

class CategoryManagementCubit extends Cubit<CategoryManagementState> {
  CategoryManagementCubit() : super(const CategoryManagementState()) {
    _fetch();
  }

  final CategoryRepository _repo = CategoryRepository.instance;

  void _fetch() async {
    try {
      final data = await Future.wait([
        _repo.getCategoryWithAttributes(),
        _repo.getAllAttributes(),
      ]);
      emit(
        state.copyWith(
          status: CategoryManagementStatus.success,
          categories: data[0] as List<Category>,
          attributes: data[1] as List<AttributeDefinition>,
        ),
      );
    } catch (e) {
      print('Error fetching data: $e');
      emit(
        state.copyWith(
          status: CategoryManagementStatus.failure,
          snackBarMessage: 'Error fetching data: $e',
        ),
      );
    }
  }

  void upsertCategory(Category category) async {
    try {
      await _repo.upsert(
        id: category.id,
        parentId: category.parentId,
        name: category.name,
        imageUrl: category.imageUrl,
        description: category.description ?? '',
      );
      _fetch(); // Re-fetch for consistency
      emit(state.copyWith(snackBarMessage: 'Category saved successfully.'));
    } catch (e) {
      emit(state.copyWith(snackBarMessage: 'Error saving category: $e'));
    }
  }

  void upsertAttribute({
    String? id,
    required String name,
    required String dataType,
    String? unit,
    List<String>? options,
  }) async {
    try {
      await _repo.upsertAttribute(
        id: id,
        name: name,
        dataType: dataType,
        unit: unit,
        options: options,
      );
      final updatedAttributes = await _repo.getAllAttributes();
      emit(
        state.copyWith(
          attributes: updatedAttributes,
          snackBarMessage: 'Attribute "$name" saved successfully.',
        ),
      );
    } catch (e) {
      emit(state.copyWith(snackBarMessage: 'Error saving attribute: $e'));
    }
  }

  void linkCategoryToAttributes(
    String catId,
    List<LinkCategoryToAtrributes> items,
  ) async {
    print('id: $catId, items: $items');
    try {
      await _repo.linkCategoryToAttributes(catId, items);
      _fetch();
    } catch (e) {
      emit(
        state.copyWith(
          snackBarMessage: 'Error linking category to attributes: $e',
        ),
      );
    }
  }
}
