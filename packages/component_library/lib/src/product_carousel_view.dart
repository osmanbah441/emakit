import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ProductCarouselView extends StatelessWidget {
  const ProductCarouselView({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) throw ('images cannot be empty');
    return SizedBox(
      height: 480,
      child: CarouselView.weighted(
        consumeMaxWeight: true,
        flexWeights: [1, 10, 1],
        itemSnapping: true,
        children: imageUrls.map((image) {
          return CachedProductImage(imageUrl: image);
        }).toList(),
      ),
    );
  }
}
