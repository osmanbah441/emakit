import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categoriesData = const [
    {
      'title': "Women's Fashion",
      'imageUrl': 'https://picsum.photos/id/1012/600/400',
    },
    {
      'title': "Men's Fashion",
      'imageUrl': 'https://picsum.photos/id/1025/600/400',
    },
    {
      'title': "Electronics",
      'imageUrl': 'https://picsum.photos/id/1047/600/400',
    },
    {
      'title': "Home & Garden",
      'imageUrl': 'https://picsum.photos/id/1074/600/400',
    },
    {'title': "Books", 'imageUrl': 'https://picsum.photos/id/237/600/400'},
    {
      'title': "Sports & Outdoors",
      'imageUrl': 'https://picsum.photos/id/1084/600/400',
    },
  ];

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop Categories (Picsum)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 2.2,
          ),
          itemCount: categoriesData.length,
          itemBuilder: (context, index) {
            final category = categoriesData[index];
            return CategoryCard(
              title: category['title'] as String,
              imageUrl: category['imageUrl'] as String,
              onTap: () {
                print('Tapped on ${category['title']}');
              },
            );
          },
        ),
      ),
    );
  }
}
