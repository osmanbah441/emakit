import 'package:add_edit_product/src/components/add_product_specification_step.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_edit_product_cubit.dart';

import 'components/upload_guideline_image_step.dart';

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
    return BlocConsumer<AddEditProductCubit, AddEditProductState>(
      listener: (context, state) {
        if (state.status == AddEditProductStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'An unknown error occurred.'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == AddEditProductStatus.loading) {
          return const Scaffold(body: CenteredProgressIndicator());
        }

        return switch (state.currentStep) {
          AddEditProductStep.guideLineImage => const UploadGuidelineImageStep(),
          AddEditProductStep.newProduct => const AddProductSpecificationStep(),
        };
      },
    );
  }
}
