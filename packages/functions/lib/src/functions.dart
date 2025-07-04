import 'package:cloud_functions/cloud_functions.dart';
import 'package:domain_models/domain_models.dart';

import 'models/models.dart';

final class MooemartFunctions {
  const MooemartFunctions._();

  static const instance = MooemartFunctions._();
  static final _function = FirebaseFunctions.instance;

  static useEmulator(String host, int port) =>
      _function.useFunctionsEmulator(host, port);

  Future<String> productSearch(MooemartPart part) async {
    final response = await _function
        .httpsCallable('productSearch')
        .call(part.toJson());

    return response.data;
  }

  Future<ProcessGuidelineImageResult> processGuidelineImage(
    List<MooemartMediaPart> parts,
  ) async {
    // final response = await _function
    //     .httpsCallable('productImageUnderstand')
    //     .call(parts.map((part) => part.toJson()).toList())
    //     .then((res) {
    //       return res.data as Map<String, dynamic>;
    //     });

    final similarProducts = [
      Product(
        id: '1',
        name: 'Vintage Leather Jacket',
        description: 'A stylish vintage leather jacket.',
        imageUrl: 'https://picsum.photos/id/237/200/300',
      ),
    ]; // TODO;

    // final generatedProduct = Product(
    //   id: '',
    //   category: response['category'],
    //   name: response['productName'],
    //   description: response['description'],
    //   specifications: response['specifications'],
    // );

    final generatedProductVariation = ProductVariation(
      id: '',
      attributes: {'size': 'M', 'color': 'brown'},
      imageUrls: [],
      price: 20.0,
      stockQuantity: 2,
    );

    final fields = [
      {
        "name": "Condition",
        "options": ["New", "Used"],
      },
      {
        "name": "Color",
        "options": ["red", "blue", "green", "yellow", "orange"],
      },
      {
        "name": "Size",
        "options": ["Small", "Medium", "Large"],
      },
    ];

    return ProcessGuidelineImageResult(
      generatedProduct: Product(name: 'product name'),
      similarProducts: similarProducts,
      generatedProductVariation: generatedProductVariation,
      productSpecificationData: {'material': 'leather', 'color': 'brown'},
      variationDefinationData: fields,
    );
  }
}
