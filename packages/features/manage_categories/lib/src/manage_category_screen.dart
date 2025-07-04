import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:manage_categories/src/add_or_edit_category_dialog.dart';
import 'package:manage_categories/src/category_notifier.dart';
import 'package:manage_categories/src/subcategory_details_screen.dart';

class ManageCategoryScreen extends StatefulWidget {
  const ManageCategoryScreen({super.key});

  @override
  State<ManageCategoryScreen> createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen> {
  late final CategoryNotifier _categoryProvider;

  @override
  void initState() {
    super.initState();
    _categoryProvider = CategoryNotifier();
  }

  @override
  void dispose() {
    _categoryProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _categoryProvider,
      builder: (context, _) {
        final state = _categoryProvider;

        return Scaffold(
          appBar: AppBar(title: const Text('Categories')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddOrEditCategoryDialog(context),
            tooltip: 'Add Main Category',
            child: const Icon(Icons.add),
          ),
          body: () {
            if (state.isLoading) {
              return const CenteredProgressIndicator();
            }

            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            }

            final mainCategories = state.mainCategories;

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: mainCategories.length,
              itemBuilder: (context, index) {
                final category = mainCategories[index];
                final subcategories = state.getSubcategories(category.id!);

                return ExpansionTile(
                  leading: CachedProductImage(
                    borderRadius: BorderRadius.circular(8),
                    imageUrl: category.imageUrl ?? 'https://picsum.photos/200',
                    width: 48,
                    height: 48,
                  ),
                  title: Text(category.name),
                  subtitle: Text('${subcategories.length} subcategories'),
                  trailing: SizedBox(
                    width: 80,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.add_box,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: () => _showAddOrEditCategoryDialog(
                            context,
                            parentId: category.id,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit_note_sharp,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: () => _showAddOrEditCategoryDialog(
                            context,
                            category: category,
                            parentId: category.id,
                          ),
                        ),
                      ],
                    ),
                  ),
                  children: subcategories.map((subCategory) {
                    return ListTile(
                      title: Text(subCategory.name),
                      onTap: () async {
                        await Navigator.push<Category>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubcategoryEditorForm(
                              category: subCategory,
                              onSave: (updated) =>
                                  _categoryProvider.updateSubcategory(
                                    subCategory.id!,
                                    variationsFields: updated,
                                  ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            );
          }(),
        );
      },
    );
  }

  void _showAddOrEditCategoryDialog(
    BuildContext context, {
    String? parentId,
    Category? category,
  }) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) => AddOrEditCategoryDialog(
        category: category,
        parentId: parentId,
        onSave: (category) => _categoryProvider.addCategory(category),
      ),
    );

    if (saved == true) {
      _categoryProvider.refresh();
    }
  }
}
