import 'package:dataconnect/dataconnect.dart';
import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';

class CategorySelectionAlertDialog extends StatelessWidget {
  const CategorySelectionAlertDialog({super.key});

  Future<List<Category>> _fetchCategories() async {
    return await DataConnect.instance.categoryRepository.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select a Category'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: FutureBuilder<List<Category>>(
          future: _fetchCategories(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting ||
                asyncSnapshot.connectionState == ConnectionState.active) {
              return const CenteredProgressIndicator();
            }

            if (asyncSnapshot.connectionState == ConnectionState.none) {
              return const Center(child: Text('No network connection.'));
            }

            final categoriesData = asyncSnapshot.data ?? [];

            if (categoriesData.isEmpty) {
              return const Center(child: Text('No categories available.'));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 2.5,
              ),
              itemCount: categoriesData.length,
              itemBuilder: (context, index) {
                final category = categoriesData[index];
                // return CategoryCard(
                //   title: category.name,
                //   imageUrl: category.imageUrl!,
                //   onTap: () {
                //     Navigator.of(context).pop(category);
                //   },
                // );
                return Placeholder();
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
