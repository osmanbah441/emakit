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
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          const Spacer(),
          SingleImagePickerWidget(
            initialImage: state.guidelineImage,
            width: 300,
            height: 300,
            onImagePicked: cubit.addGuidelineImage,
            onImageRemoved: cubit.removeGuidelineImage,
          ),
          Text(
            "Please upload a clear image of your product. This helps us categorize it accurately, ensure it meets our guidelines, and suggest similar products so you can quickly add variations.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          ButtonActionBar(
            leftLabel: 'Cancel',
            rightLabel: 'Upload Image',
            onLeftTap: () => Navigator.pop(context),
            onRightTap: state.guidelineImage == null
                ? null
                : cubit.productExtractionListing,
          ),
        ],
      );
    },
  );
}
