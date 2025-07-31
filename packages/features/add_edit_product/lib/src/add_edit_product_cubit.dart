import 'dart:typed_data';

import 'package:api/api.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_edit_product_state.dart';

class AddEditProductCubit extends Cubit<AddEditProductState> {
  AddEditProductCubit() : super(const AddEditProductState());

  final _productRepository = Api.instance.productRepository;

  void goToStep(AddEditProductStep step) => emit(
    state.copyWith(currentStep: step, status: AddEditProductStatus.initial),
  );

  void productExtractionListing() async {
    if (state.guidelineImage == null) return;
    emit(state.copyWith(status: AddEditProductStatus.loading));
    try {
      final result = await _productRepository.productExtractionListing(
        UserContentMedia(
          state.guidelineImage!.bytes,
          state.guidelineImage!.mimeType,
        ),
      );
      emit(
        state.copyWith(
          extractedProductInfo: result,
          status: AddEditProductStatus.success,
          currentStep: AddEditProductStep.newProduct,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AddEditProductStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void removeGuidelineImage() => emit(const AddEditProductState());

  void addGuidelineImage(({Uint8List bytes, String mimeType}) image) {
    emit(state.copyWith(guidelineImage: image));
  }

  void verifyVariation({
    required double price,
    required int stock,
    required Map<String, dynamic> selectedAttributesMap,
    required List<({Uint8List bytes, String mimeType})> images,
  }) async {
    // TODO: Validate verification using llm
    emit(
      state.copyWith(
        price: price,
        availableStock: stock,
        variationAttributes: selectedAttributesMap,
        imagesData: images,
        isVariationValid: true,
      ),
    );
  }

  void createNewProduct({
    required String name,
    required String description,
    required Map<String, dynamic> specifications,
  }) async {
    emit(state.copyWith(status: AddEditProductStatus.loading));

    try {
      await _productRepository.createNewProduct(
        name: name,
        description: description,
        category: state.extractedProductInfo!.generatedProduct.categoryId!,
        specs: specifications,
        attributes: state.variationAttributes!,
        imagesData: state.imagesData!,
        price: state.price!,
        availableStock: state.availableStock!,
      );

      emit(state.copyWith(status: AddEditProductStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: AddEditProductStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
