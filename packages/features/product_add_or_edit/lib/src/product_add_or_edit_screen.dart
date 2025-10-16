import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:image_picker/image_picker.dart';

import 'product_form.dart';

class ProductAddOrEditScreen extends StatelessWidget {
  const ProductAddOrEditScreen({
    super.key,
    this.productId,
    this.image,
    this.category,
  });

  final String? productId;
  final XFile? image;
  final Category? category;

  @override
  Widget build(BuildContext context) {
    // final categoryType = category!.type;
    // if (categoryType == null) {
    //   return Center(child: Text('Failed to map this category contact admin'));
    // }

    // return ProductFormScreen(category: categoryType, image: image!);
    return Center(child: Text('product add screen'));
  }
}
