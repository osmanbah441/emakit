import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_cubit.dart';
import 'filter_section.dart';
import 'product_section.dart';
import 'package:component_library/component_library.dart'; // For CenteredProgressIndicator

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryDetailsCubit(id: id),
      child: const FilterScreenView(),
    );
  }
}

class FilterScreenView extends StatelessWidget {
  const FilterScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
      builder: (context, state) {
        if (state is! CategoryDetailsLoaded) {
          return const Scaffold(body: CenteredProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(state.fiteredProducts.first.mainCategory),
            actions: [
              IconButton(
                icon: Icon(
                  state.showFilters ? Icons.filter_alt_off : Icons.filter_list,
                ),
                onPressed: () => context
                    .read<CategoryDetailsCubit>()
                    .toggleFiltersVisibility(),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Visibility(
                  visible: state.showFilters,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FilterSection(state: state),
                  ),
                ),
              ),
              Expanded(
                child: ProductSection(
                  onProductTap: (context, productId) {},
                  products: state.fiteredProducts,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
