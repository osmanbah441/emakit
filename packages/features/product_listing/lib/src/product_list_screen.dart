import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/src/image_upload_step.dart';

import 'complete.dart';
import 'product_listing_cubit.dart';
import 'upload_images.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit(),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("New Product")),
            body: state.loading
                ? const Center(child: CircularProgressIndicator())
                : IndexedStack(
                    index: state.currentStep,
                    children: const [
                      UploadImageScreen(),
                      CompleteSpecsScreen(),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
