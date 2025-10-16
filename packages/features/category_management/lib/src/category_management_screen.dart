import 'package:category_management/src/attribute_definition_table.dart';
import 'package:category_management/src/category_definition_table.dart';
import 'package:category_management/src/category_management_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryManagementCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Category & Attribute Management'),
          centerTitle: false,
        ),
        body: BlocConsumer<CategoryManagementCubit, CategoryManagementState>(
          listener: (context, state) {
            if (state.snackBarMessage != null) {
              _showSnackbar(context, state.snackBarMessage!);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case CategoryManagementStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case CategoryManagementStatus.failure:
                return const Center(
                  child: Text('Failed to load data. Please try again.'),
                );
              case CategoryManagementStatus.success:
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabs: const [
                          Tab(text: 'Categories'),
                          Tab(text: 'Attribute Definitions'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            CategoryDefinitionTable(),
                            AttributeDefinitionTable(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
