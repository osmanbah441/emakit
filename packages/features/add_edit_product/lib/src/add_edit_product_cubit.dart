import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:functions/functions.dart';

part 'add_edit_product_state.dart';

class AddEditProductCubit extends Cubit<AddEditProductState> {
  AddEditProductCubit() : super(const AddEditProductState());

  // final _func = MooemartFunctions.instance;

  void nextStep() {
    emit(
      state.copyWith(
        currentStep: state.currentStep + 1,
        currentProgressIndicator: state.currentProgressIndicator + 0.25,
      ),
    );
  }

  void previousStep() {
    emit(
      state.copyWith(
        currentStep: state.currentStep - 1,
        currentProgressIndicator: state.currentProgressIndicator - 0.25,
      ),
    );
  }

  void processGuidelineImage() async {
    // final res = await _func.processGuidelineImage([
    //   MooemartMediaPart(
    //     state.guidelineImage!.bytes,
    //     state.guidelineImage!.mimeType,
    //   ),
    // ]);

    // replace with actual similar products
    final similarProduct = [
      Product(
        imageUrl: 'https://picsum.photos/seed/dress1/400/400',
        title: 'Floral Print Dress',
        subtitle: 'Women\'s dress',
      ),
      Product(
        imageUrl: 'https://picsum.photos/seed/dress2/400/400',
        title: 'Summer Dress',
        subtitle: 'Women\'s dress',
      ),
      Product(
        imageUrl: 'https://picsum.photos/seed/dress3/400/400',
        title: 'Casual Dress',
        subtitle: 'Women\'s dress',
      ),
    ];

    final initialVariationData = {
      'Product name': 'Gaming PC',
      'Color': 'Silver',
      'Size': '15-inch',
      'Is Available': true,
      'Quantity': 10,
      'Has Warranty': false,
      'Condition': ['New', 'Fair Used', 'Good'],
    };

    final initialSpecificationData = {
      'Product name': 'Gaming PC',
      'Weight': 2.0,
      'Dimensions': '35.7 x 23.5 x 1.7 cm',
      'Brand': 'Dell',
      'Model': 'XPS 15',
      'Material': 'Aluminum',
    };

    emit(
      state.copyWith(
        similarProducts: similarProduct,
        productSpecificationData: initialSpecificationData,
        productVariationData: initialVariationData,
      ),
    );

    nextStep();
  }

  void uploadImages() async {
    final picked = await _pickImage();
    if (picked != null) {
      emit(state.copyWith(uploadedImages: [...state.uploadedImages, picked]));
    }
  }

  void removeUploadedImage((String, Uint8List) image) {
    final index = state.uploadedImages.indexOf(image);
    final images = [...state.uploadedImages];
    images.removeAt(index);
    emit(state.copyWith(uploadedImages: images));
  }

  void uploadGuildelineImage() async {
    final picked = await _pickImage();
    if (picked != null) {
      emit(
        state.copyWith(guidelineImage: (mimeType: picked.$1, bytes: picked.$2)),
      );
    }
  }

  void removeGuidelineImage() => emit(const AddEditProductState());

  Future<(String, Uint8List)?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      return (picked.mimeType!, bytes);
    }
    return null;
  }

  void onSelectedParentProduct(Product product) {
    emit(
      state.copyWith(
        selectedParentProduct: product,
        isCreatingFromExistingProduct: true,
      ),
    );
    nextStep();
  }

  void onCreateNewListing() {
    emit(state.copyWith(isCreatingFromExistingProduct: false));
    nextStep();
  }

  void addProductVariation(Map<String, dynamic> data) {
    emit(state.copyWith(productVariationData: data));

    // TODO: remove
    if (!state.isCreatingFromExistingProduct) {
      emit(state.copyWith(isPotentialDuplicateDetected: true));
    }
    nextStep();
  }

  void addProductSpecification(Map<String, dynamic> data) {
    emit(state.copyWith(productSpecificationData: data));
    nextStep();
  }
}
