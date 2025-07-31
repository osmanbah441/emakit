import 'dart:typed_data';

import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart' hide ProductCard;
import 'package:store_product_details/src/product_card.dart';
import 'package:store_product_details/src/store_product_details_cubit.dart';

class StoreProductDetailsScreen extends StatelessWidget {
  const StoreProductDetailsScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreProductDetailsCubit(productId),
      child: StoreProductDetailsView(),
    );
  }
}

// @visibleForTesting
// class StoreProductDetailsView extends StatelessWidget {
//   const StoreProductDetailsView({super.key});

//   void _showCenteredDialog({
//     required BuildContext context,
//     required Widget child,
//   }) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Material(
//             color: Colors.transparent,
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 500),
//               child: SingleChildScrollView(child: child),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<StoreProductDetailsCubit>();

//     return BlocBuilder<StoreProductDetailsCubit, StoreProductDetailsState>(
//       builder: (context, state) {
//         print(state.status);
//         if (state.status.isInitial) return const CenteredProgressIndicator();
//         if (state.product == null && state.status.isSuccess) {
//           return Center(child: Text('Product not found'));
//         }
//         if (state.product!.variations.isEmpty) {
//           return const Center(child: Text('No variations yet.'));
//         }
//         return Scaffold(
//           body: Column(
//             children: [
//               ProductCard(
//                 name: state.product!.name,
//                 description: state.product!.description,
//                 imageUrl: state.product!.variations.first.imageUrls.first,
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   itemCount: state.product!.variations.length,
//                   itemBuilder: (_, index) {
//                     final variation = state.product!.variations[index];
//                     return ProductVariationCard(
//                       id: variation.id,
//                       initialPrice: variation.price.toString(),
//                       initialStock: variation.stockQuantity.toString(),
//                       selectedOptions: variation.attributes,
//                       imagesFromNetwork: variation.imageUrls,
//                       isActive: variation.status == ProductStatus.active,

//                       mode: ProductVariationMode.view,

//                       onEdit: () {
//                         _showCenteredDialog(
//                           context: context,
//                           child: ProductVariationCard(
//                             id: variation.id,
//                             initialPrice: variation.price.toString(),
//                             initialStock: variation.stockQuantity.toString(),
//                             selectedOptions: variation.attributes,
//                             imagesFromNetwork: variation.imageUrls,
//                             mode: ProductVariationMode.edit,
//                             onToggleActive: (active) =>
//                                 cubit.toggleActive(variation.id, active),
//                             onUpdate:
//                                 ({required double price, required int stock}) {
//                                   cubit.updateVariation(
//                                     id: variation.id,
//                                     price: price,
//                                     stock: stock,
//                                   );
//                                   Navigator.pop(context);
//                                 },
//                             onCancel: () => Navigator.pop(context),
//                           ),
//                         );
//                       },
//                       onDelete: () => cubit.deleteVariation(variation.id),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               _showCenteredDialog(
//                 context: context,
//                 child: ProductVariationCard(
//                   mode: ProductVariationMode.add,

//                   optionalFields: state.variationDefinationFields ?? {},

//                   onAdd:
//                       ({
//                         required double price,
//                         required int stock,
//                         required Map<String, dynamic> selectedAttributesMap,
//                         required List<({Uint8List bytes, String mimeType})>
//                         images,
//                       }) async {
//                         cubit.addVariation(
//                           price: price,
//                           stock: stock,
//                           selectedAttributesMap: selectedAttributesMap,
//                           images: images,
//                         );
//                         Navigator.pop(context);
//                       },
//                   onCancel: () => Navigator.pop(context),
//                 ),
//               );
//             },
//             child: const Icon(Icons.add),
//           ),
//         );
//       },
//     );
//   }
// }

@visibleForTesting
class StoreProductDetailsView extends StatelessWidget {
  const StoreProductDetailsView({super.key});

  void _showCenteredDialog({
    required BuildContext context,
    required Widget child,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: SingleChildScrollView(child: child),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StoreProductDetailsCubit>();

    return BlocBuilder<StoreProductDetailsCubit, StoreProductDetailsState>(
      builder: (context, state) {
        print(state.status);
        if (state.status.isInitial || state.status.isLoading) {
          // Added isLoading to initial checks
          return const CenteredProgressIndicator();
        }
        if (state.status.isError) {
          // Handle error state explicitly
          return Center(
            child: Text('Error: ${state.error ?? "Unknown error"}'),
          );
        }
        if (state.product == null && state.status.isSuccess) {
          return Center(child: Text('Product not found'));
        }
        // Add a null check for product before accessing its properties
        if (state.product == null || state.product!.variations.isEmpty) {
          return const Center(child: Text('No variations yet.'));
        }
        return Scaffold(
          body: Column(
            children: [
              // Now it's safe to use state.product! because of the checks above
              ProductCard(
                name: state.product!.name,
                description: state.product!.description,
                // Ensure imageUrls is not empty before accessing first
                imageUrl: state.product!.variations.first.imageUrls.isNotEmpty
                    ? state.product!.variations.first.imageUrls.first
                    : 'https://via.placeholder.com/150', // Provide a fallback image
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.product!.variations.length,
                  itemBuilder: (_, index) {
                    final variation = state.product!.variations[index];
                    return ProductVariationCard(
                      id: variation.id,
                      initialPrice: variation.price.toString(),
                      initialStock: variation.stockQuantity.toString(),
                      selectedOptions: variation.attributes,
                      imagesFromNetwork: variation.imageUrls,
                      isActive: variation.status == ProductStatus.active,
                      mode: ProductVariationMode.view,
                      onEdit: () {
                        _showCenteredDialog(
                          context: context,
                          child: ProductVariationCard(
                            id: variation.id,
                            initialPrice: variation.price.toString(),
                            initialStock: variation.stockQuantity.toString(),
                            selectedOptions: variation.attributes,
                            imagesFromNetwork: variation.imageUrls,
                            mode: ProductVariationMode.edit,
                            onToggleActive: (active) =>
                                cubit.toggleActive(variation.id, active),
                            onUpdate:
                                ({required double price, required int stock}) {
                                  cubit.updateVariation(
                                    id: variation.id,
                                    price: price,
                                    stock: stock,
                                  );
                                  Navigator.pop(context);
                                },
                            onCancel: () => Navigator.pop(context),
                          ),
                        );
                      },
                      onDelete: () => cubit.deleteVariation(variation.id),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showCenteredDialog(
                context: context,
                child: ProductVariationCard(
                  mode: ProductVariationMode.add,
                  optionalFields: state.variationDefinationFields ?? {},
                  onAdd:
                      ({
                        required double price,
                        required int stock,
                        required Map<String, dynamic> selectedAttributesMap,
                        required List<({Uint8List bytes, String mimeType})>
                        images,
                      }) async {
                        cubit.addVariation(
                          price: price,
                          stock: stock,
                          selectedAttributesMap: selectedAttributesMap,
                          images: images,
                        );
                        Navigator.pop(context);
                      },
                  onCancel: () => Navigator.pop(context),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
