import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_edit_product_cubit.dart';

class SimilarProductsStep extends StatefulWidget {
  const SimilarProductsStep({super.key});

  @override
  State<SimilarProductsStep> createState() => _SimilarProductsStepState();
}

class _SimilarProductsStepState extends State<SimilarProductsStep> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEditProductCubit>();
    return Column(
      spacing: 16.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'We found similar products in our catalog. Select one to list yours or create a new listing.',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w100),
        ),

        // List of similar product items
        Expanded(
          child: BlocBuilder<AddEditProductCubit, AddEditProductState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.similarProducts.length,
                itemBuilder: (context, index) {
                  final product = state.similarProducts[index];
                  return ProductListItem(
                    imageUrl: product.imageUrl,
                    title: product.title,
                    subtitle: product.subtitle,
                    onTap: () => cubit.onSelectedParentProduct(product),
                  );
                },
              );
            },
          ),
        ),
        ButtonActionBar(
          leftLabel: 'Back',
          rightLabel: "Create New Product",
          onLeftTap: cubit.previousStep,
          onRightTap: cubit.onCreateNewListing,
        ),
      ],
    );
  }
}
