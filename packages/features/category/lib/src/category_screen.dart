import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:dataconnect/dataconnect.dart';

import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  Future<List<Category>> categories() async {
    return await DataconnectService.instance.fetchCategories();
  }

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categories(),
      builder: (context, asyncSnapshot) {
        final categoriesData = asyncSnapshot.data ?? [];

        return switch (asyncSnapshot.connectionState) {
          ConnectionState.none => throw UnimplementedError(),
          ConnectionState.waiting => const CenteredProgressIndicator(),
          ConnectionState.active => const CenteredProgressIndicator(),
          ConnectionState.done => Padding(
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
                  title: category.name,
                  imageUrl: category.imageUrl,
                  onTap: () {
                    print('Tapped on ${category.name}');
                  },
                );
              },
            ),
          ),
        };
      },
    );
  }
}
