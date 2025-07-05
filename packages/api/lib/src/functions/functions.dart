import 'package:api/api.dart';
import 'package:domain_models/domain_models.dart';
import 'package:cloud_functions/cloud_functions.dart';

final class Functions {
  const Functions._();
  static const instance = Functions._();

  static final _fn = FirebaseFunctions.instance;

  Future<String> productSearch(UserContent content) async {
    var res = await _fn.httpsCallable('productSearch').call(content.toJson());
    return res.data;
  }

  Future<ProcessGuidelineImageResult> processProductGuidelineImage(
    UserContent content,
  ) async {
    final response = await _fn
        .httpsCallable('productImageUnderstand')
        .call([content.toJson()])
        .then((res) {
          return res.data as Map<String, dynamic>;
        });

    final similarProducts = [
      Product(
        id: '1',
        name: 'Vintage Leather Jacket',
        description: 'A stylish vintage leather jacket.',
        imageUrl: 'https://picsum.photos/id/237/200/300',
      ),
    ]; // TODO;

    final generatedProduct = Product(
      id: '',
      name: response['productName'],
      description: response['description'],
      specifications: response['specifications'],
    );

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
      generatedProduct: generatedProduct,
      similarProducts: similarProducts,
      generatedProductVariation: generatedProductVariation,
      productSpecificationData: {'material': 'leather', 'color': 'brown'},
      variationDefinationData: fields,
    );
  }
}
