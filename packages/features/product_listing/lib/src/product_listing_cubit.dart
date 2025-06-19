import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functions/functions.dart';

part 'product_listing_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState());

  void updateGeneratedInfo({
    required String name,
    required String description,
    required Map<String, String> specs,
    required String category,
  }) {
    emit(
      state.copyWith(
        name: name,
        description: description,
        specs: specs,
        category: category,
      ),
    );
  }

  void updateSpecs(Map<String, String> specs) {
    emit(state.copyWith(specs: specs));
  }

  void nextStep() {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void previousStep() {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void goToStep(int step) {
    emit(state.copyWith(currentStep: step));
  }

  void uploadImages(List<({String mimeType, Uint8List bytes})> images) async {
    final parts = images
        .map((i) => MooemartMediaPart(i.bytes, i.mimeType))
        .toList();

    final res = MooemartFunctions.instance.productImageUnderstand(parts);
    print(res);
  }
}
