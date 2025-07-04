import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_edit_product_cubit.dart';

class PotentialDuplicatedDetected extends StatelessWidget {
  const PotentialDuplicatedDetected({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<AddEditProductCubit>();

    return Scaffold(
      body: Builder(
        builder: (context) {
          return BlocBuilder<AddEditProductCubit, AddEditProductState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    IconButton(
                      onPressed: () =>
                          cubit.goToStep(AddEditProductStep.newProduct),
                      icon: Icon(Icons.arrow_back),
                      tooltip: 'Back to new product',
                    ),
                    Text(
                      "This product looks similar to one already on our platform. To avoid duplicate listings, we recommend adding it as a new variation.",
                      style: textTheme.bodyLarge,
                    ),
                    ProductCarouselView(
                      imageUrls: [state.detectedSimilarProduct!.imageUrl!],
                    ),
                    const Spacer(),
                    PrimaryActionButton(
                      onPressed: () => cubit.setPotentialDuplicate(false),
                      label: 'Yes, this is the same product.',
                    ),
                    PrimaryActionButton(
                      onPressed: () => cubit.setPotentialDuplicate(true),
                      label: 'No, my product is different.',
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
