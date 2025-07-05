import 'dart:typed_data';

import 'package:api/api.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_edit_product_state.dart';

class AddEditProductCubit extends Cubit<AddEditProductState> {
  AddEditProductCubit() : super(const AddEditProductState());

  double get currentProgressIndicator {
    int totalSteps = AddEditProductStep.values.length - 1;
    if (state.creatingFromExistingProduct != null) {
      totalSteps = AddEditProductStep.values.length - 1;
    }

    return state.currentStep.index / totalSteps;
  }

  void goToStep(AddEditProductStep step) => emit(
    state.copyWith(currentStep: step, status: AddEditProductStatus.initial),
  );

  void setPotentialDuplicate(bool isDuplicate) {
    emit(state.copyWith(isFlaggedAsDuplicate: isDuplicate));
    goToStep(AddEditProductStep.newVariation);
  }

  void processGuidelineImage() async {
    if (state.guidelineImage == null) return;
    if (state.similarProducts.isNotEmpty ||
        state.newProduct != null ||
        state.newProductVariation != null) {
      return goToStep(AddEditProductStep.similarProducts);
    }
    emit(state.copyWith(status: AddEditProductStatus.loading));
    try {
      final result = await Api.instance.productRepository
          .processProductGuidelineImage(
            UserContentMedia(
              state.guidelineImage!.bytes,
              state.guidelineImage!.mimeType,
            ),
          );

      final category = await Api.instance.categoryRepository.getCategoryById(
        "29139e6ac4034888967041cff3670fff",
      );
      emit(
        state.copyWith(
          similarProducts: result.similarProducts,
          newProduct: result.generatedProduct,
          variationFields: category,
          newProductVariation: result.generatedProductVariation,
          status: AddEditProductStatus.success,
          currentStep: AddEditProductStep.similarProducts,
        ),
      );
    } catch (e) {
      print(e.toString());

      emit(
        state.copyWith(
          status: AddEditProductStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  createProductVariation({
    required double price,
    required int stockQuantity,
    required Map<String, dynamic> attributes,
    required List<({Uint8List bytes, String mimeType})> images,
  }) async {}

  void validateProductWithLLM({
    required String name,
    required String description,
    required Map<String, dynamic> specifications,
  }) async {
    final newProduct = Product(
      name: name,
      description: description,
      specifications: specifications,
    );

    emit(
      state.copyWith(
        status: AddEditProductStatus.loading,
        newProduct: newProduct,
        creatingFromExistingProduct: null,
      ),
    );
    try {
      emit(
        state.copyWith(
          status: AddEditProductStatus.success,
          currentStep: AddEditProductStep.newVariation,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AddEditProductStatus.potentailDuplicateDetected,
          detectedSimilarProduct: Product(
            name: name,
            description: description,
            imageUrl: 'https://picsum.photos/id/237/200/300',
          ),
        ),
      );
    }
  }

  void removeGuidelineImage() => emit(const AddEditProductState());

  void createNewProduct({Product? exist}) {
    emit(
      state.copyWith(
        creatingFromExistingProduct: exist,
        currentStep: exist != null
            ? AddEditProductStep.newVariation
            : AddEditProductStep.newProduct,
      ),
    );
  }

  void addGuidelineImage(({Uint8List bytes, String mimeType}) image) {
    emit(state.copyWith(guidelineImage: image));
  }
}
