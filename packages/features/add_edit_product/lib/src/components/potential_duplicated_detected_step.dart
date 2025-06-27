import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_edit_product_cubit.dart';

class PotentialDuplicatedDetectedStep extends StatelessWidget {
  const PotentialDuplicatedDetectedStep({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<AddEditProductCubit>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: cubit.previousStep,
                icon: Icon(Icons.arrow_back),
                tooltip: 'Back',
              ),
              const SizedBox(width: 8),
              Text(
                'Vintage Leather Jacket',
                style: textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text(
            "This product looks similar to one already on our platform. To avoid duplicate listings, we recommend adding it as a new variation.",
            style: textTheme.bodyMedium,
          ),
          ProductCarouselView(
            imageUrls: [
              'https://picsum.photos/id/237/200/300', // Dog picture
              'https://picsum.photos/id/292/200/300', // Ocean view
              'https://picsum.photos/id/1018/200/300', // Mountain lake
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                print('Select existing product pressed');
              },
              child: const Text('Add as Variation (Recommended)'),
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                print('Continue with new product pressed');
              },
              child: const Text('List as New (Review in 24 hours)'),
            ),
          ),
        ],
      ),
    );
  }
}
