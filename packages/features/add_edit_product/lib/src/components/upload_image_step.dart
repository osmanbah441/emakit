import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_edit_product_cubit.dart';
import 'display_memory_image.dart';
import 'image_placeholder.dart';

class UploadImageStep extends StatelessWidget {
  const UploadImageStep({super.key});
  final double _imageWidth = 300;
  final double _imageHeight = 300;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditProductCubit, AddEditProductState>(
      builder: (context, state) {
        final cubit = context.read<AddEditProductCubit>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 32,
          children: [
            Text(
              "Please show us your product by uploading a clear image. This helps us categorize your product and ensure it meets our platform's guidelines.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            if (state.guidelineImage == null)
              ImagePlaceholder(
                width: _imageWidth,
                height: _imageHeight,
                onTap: cubit.uploadGuildelineImage,
              )
            else ...[
              DisplayMemoryImage(
                imageBytes: state.guidelineImage!.bytes,
                onRemove: cubit.removeGuidelineImage,
                width: _imageWidth,
                height: _imageHeight,
              ),
              PrimaryActionButton(
                onPressed: cubit.processGuidelineImage,
                label: 'Upload image',
                icon: Icon(Icons.upload_file),
              ),
            ],
          ],
        );
      },
    );
  }
}
