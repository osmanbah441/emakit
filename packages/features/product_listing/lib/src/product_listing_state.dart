part of 'product_listing_cubit.dart';

class ProductState {
  final int currentStep;
  final List<({String mimeType, Uint8List bytes})> imageBytes;
  final String? name;
  final String? description;
  final String? category;
  final Map<String, String> specs;
  final bool loading;
  final List<String> requiredSpecsByCategory;

  const ProductState({
    this.currentStep = 0,
    this.imageBytes = const [],
    this.name,
    this.description,
    this.category,
    this.specs = const {},
    this.loading = false,
    this.requiredSpecsByCategory = const [],
  });

  ProductState copyWith({
    int? currentStep,
    List<({String mimeType, Uint8List bytes})>? imageBytes,
    String? name,
    String? description,
    String? category,
    Map<String, String>? specs,
    List<String>? requiredSpecsByCategory,
    bool? loading,
  }) {
    return ProductState(
      currentStep: currentStep ?? this.currentStep,
      imageBytes: imageBytes ?? this.imageBytes,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      specs: specs ?? this.specs,
      loading: loading ?? this.loading,
      requiredSpecsByCategory:
          requiredSpecsByCategory ?? this.requiredSpecsByCategory,
    );
  }
}
