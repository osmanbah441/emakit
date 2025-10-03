import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_edit_product_cubit.dart';

class UploadGuidelineImageStep extends StatelessWidget {
  const UploadGuidelineImageStep({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<AddEditProductCubit, AddEditProductState>(
    builder: (context, state) {
      final AddEditProductCubit cubit = context.read<AddEditProductCubit>();
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 32,
              children: [
                Text(
                  "Please upload a clear image of your product. This helps us categorize it accurately, ensure it meets our guidelines, and suggest similar products so you can quickly add variations.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SingleImagePickerWidget(
                  borderRadius: BorderRadius.circular(24),
                  initialImage: state.guidelineImage,
                  width: 300,
                  height: 400,
                  onImagePicked: cubit.addGuidelineImage,

                  onImageRemoved: cubit.removeGuidelineImage,
                ),

                ExtendedElevatedButton(
                  label: 'Continue',
                  onPressed: state.guidelineImage == null
                      ? null
                      : cubit.productExtractionListing,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
