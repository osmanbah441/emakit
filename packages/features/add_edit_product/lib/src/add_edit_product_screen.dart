import 'package:add_edit_product/src/components/add_product_specification_step.dart';
import 'package:add_edit_product/src/components/add_product_variation_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_edit_product_cubit.dart';

import 'components/add_variation_images.dart';
import 'components/potential_duplicated_detected_step.dart';
import 'components/similar_product_step.dart';
import 'components/upload_image_step.dart';

class AddEditProductScreen extends StatelessWidget {
  const AddEditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditProductCubit(),
      child: const AddEditProductView(),
    );
  }
}

@visibleForTesting
class AddEditProductView extends StatelessWidget {
  const AddEditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditProductCubit, AddEditProductState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24, 16, 32),
            child: Column(
              spacing: 16,
              children: [
                LinearProgressIndicator(value: state.currentProgressIndicator),
                Expanded(
                  child: IndexedStack(
                    index: state.currentStep,
                    children: [
                      const UploadImageStep(),
                      const SimilarProductsStep(),
                      if (!state.isCreatingFromExistingProduct)
                        const AddProductSpecificationStep(),
                      const AddProductVariationStep(),
                      const AddVariationImages(),
                      if (state.isPotentialDuplicateDetected)
                        const PotentialDuplicatedDetectedStep(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
