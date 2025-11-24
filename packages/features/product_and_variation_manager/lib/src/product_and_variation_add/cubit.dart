import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:category_repository/category_repository.dart';
import 'package:domain_models/domain_models.dart';

part 'state.dart';

class ProductAddVariationCubit extends Cubit<ProductAddVariationState> {
  ProductAddVariationCubit({
    required ProductRepository productRepository,
    required CategoryRepository categoryRepository,
  }) : _productRepository = productRepository,
       _categoryRepository = categoryRepository,
       super(ProductAddVariationInitial());

  final ProductRepository _productRepository;
  final CategoryRepository _categoryRepository;

  Future<void> search() async {
    emit(ProductAddVariationLoading());

    final products = await _productRepository.getStoreProductWithOffer();
    final categories = await _categoryRepository.productCategory();

    emit(
      ProductAddVariationSearchSuccess(
        products: products,
        categories: categories,
        // isNewVariation is null, indicating the product list screen
      ),
    );
  }

  void setStateToSearchResult() {
    final currentState = state;
    if (currentState is ProductAddVariationSearchSuccess) {
      // Set isNewVariation to null to explicitly show the search/list screen
      emit(currentState.copyWith(isNewVariation: null));
    } else {
      // Fallback for cases where the state might not be SearchSuccess
      emit(ProductAddVariationSearchSuccess());
    }
  }

  void selectProduct() {
    final currentState = state;
    if (currentState is ProductAddVariationSearchSuccess) {
      // Use copyWith to indicate offer creation (isNewVariation: false)
      emit(currentState.copyWith(isNewVariation: false));
    }
  }

  void createNewVariation() {
    final currentState = state;
    if (currentState is ProductAddVariationSearchSuccess) {
      // Use copyWith to indicate new variation creation (isNewVariation: true)
      emit(currentState.copyWith(isNewVariation: true));
    }
  }

  void setProductFields({
    required String name,
    required String manufacturer,
    required String categoryId,
    required String description,
    required Map<String, String> specs,
  }) {
    final currentState = state;
    if (currentState is ProductAddVariationSearchSuccess) {
      emit(
        currentState.copyWith(
          name: name,
          manufacturer: manufacturer,
          categoryId: categoryId,
          description: description,
          specs: specs,
          isNewVariation: true,
        ),
      );
    }
  }

  void createProductWithVariationAndOffer({
    required double price,
    required int stock,
    required List<String> imageUrls,
    required Map<String, String> variationAttributes,
  }) async {
    final currentState = state;
    if (currentState is ProductAddVariationSearchSuccess) {
      await _productRepository.createProductWithVariationAndOffer(
        name: currentState.name!,
        manufacturer: currentState.manufacturer!,
        categoryId: currentState.categoryId!,
        description: currentState.description!,
        specs: currentState.specs!,
        price: price,
        stock: stock,
        imageUrls: imageUrls,
        variationAttributes: variationAttributes,
      );
    }
  }

  void createVariationAndOffer({
    required String productId,
    required double price,
    required int stock,
    required List<String> imageUrls,
    required Map<String, String> variationAttributes,
  }) async {
    await _productRepository.createVariationAndOffer(
      productId: productId,
      storeId: '1',
      price: price,
      stock: stock,
      attributes: variationAttributes,
      imageUrls: imageUrls,
    );
  }

  void createOffer({
    required String variantId,
    required double price,
    required int stock,
  }) async {
    await _productRepository.createOffer(
      variantId: variantId,
      storeId: '1',
      price: price,
      stock: stock,
    );
  }
}
