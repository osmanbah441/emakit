import 'package:add_edit_product/src/add_edit_product_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'display_memory_image.dart';
import 'image_placeholder.dart';

class AddVariationImages extends StatelessWidget {
  const AddVariationImages({super.key});

  final _maxImages = 5;
  final _minImages = 3;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<AddEditProductCubit, AddEditProductState>(
        builder: (context, state) {
          final cubit = context.read<AddEditProductCubit>();
          final canUploadImage = state.uploadedImages.length < _maxImages;

          return Column(
            spacing: 16.0,
            children: [
              Text(
                "Help shoppers see your product perfectly! Add 3-5 images, making sure they're of the same product but from unique angles.",
                style: Theme.of(context).textTheme.titleMedium,
              ),

              Wrap(
                spacing: 8.0,
                runSpacing: 16.0,
                children: [
                  ...state.uploadedImages.map((image) {
                    return DisplayMemoryImage(
                      imageBytes: image.$2,
                      onRemove: () => cubit.removeUploadedImage(image),
                    );
                  }),
                  if (canUploadImage)
                    ImagePlaceholder(
                      onTap: cubit.uploadImages,
                      height: 160,
                      width: 160,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              ButtonActionBar(
                leftLabel: 'Back',
                rightLabel: 'Upload Images',
                onLeftTap: cubit.previousStep,
                onRightTap: (state.uploadedImages.length < _minImages)
                    ? null
                    : () {
                        if (state.isPotentialDuplicateDetected) {
                          cubit.nextStep();
                        }
                      },
              ),
            ],
          );
        },
      ),
    );
  }
}
