import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_and_variation_manager/src/components/add_variation_form.dart';
import 'package:product_repository/product_repository.dart';
import 'package:component_library/component_library.dart';

enum _ProductCreationStatus {
  idle,
  loading,
  success,
  error,
}

class CreateNewProductWithVariationAndOffer extends StatefulWidget {
  const CreateNewProductWithVariationAndOffer({
    super.key,
    required this.productFormData,
    required this.productRepository, required this.onManageOffer,
  });

  final ProductRepository productRepository;
  final ProductFormData productFormData;
  
 final  VoidCallback onManageOffer;

  @override
  State<CreateNewProductWithVariationAndOffer> createState() =>
      _CreateNewProductWithVariationAndOfferState();
}

class _CreateNewProductWithVariationAndOfferState
    extends State<CreateNewProductWithVariationAndOffer> {
  _ProductCreationStatus _status = _ProductCreationStatus.idle;
  List<String> _imageUrls = [];

  void _submit({
    required Map<String, String> selectedAttributes,
    required double price,
    required int stock,
    required List<String> imageUrls,
  }) async {
    setState(() {
      _status = _ProductCreationStatus.loading;
_imageUrls = imageUrls;
    });

    try {
      await widget.productRepository.createProductWithVariationAndOffer(
        name: widget.productFormData.name,
        manufacturer: widget.productFormData.manufacturer,
        categoryId: widget.productFormData.categoryId,
        description: widget.productFormData.description,
        specs: widget.productFormData.specifications,
        price: price,
        stock: stock,
        imageUrls: imageUrls,
        variationAttributes: selectedAttributes,
      );

      setState(() {
        _status = _ProductCreationStatus.success;
      });
   

    } catch (e) {
      // Set state to error and show Snackbar
      setState(() {
        _status = _ProductCreationStatus.error;
      });

      if (mounted) {
        ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
          SnackBar(
             content: Text('Failed to create product and offer: ${e.toString()}')),
        );
      }
      // Reset status to idle so the user can try again
      setState(() {
        _status = _ProductCreationStatus.idle;
      });
    }
  }

  // 3. Updated build method to render components based on state
  @override
  Widget build(BuildContext context) {
    // If successful, show the success screen/component
    if (_status == _ProductCreationStatus.success) {
      return AppSuccessView(
      title: "Your new product is now available.",
      content: ProductImageCarousel(imageUrls: _imageUrls, borderRadius: BorderRadius.circular(16),),
      actionLabel: 'Manage All Offers',
      onAction: widget.onManageOffer,
    );
    }

    return  SafeArea(
        child: Stack(
          children: [
            // Main Form Content
            AddVariationForm(
              attributeFields: widget.productFormData.variationAttributes,
              onSubmitted: _submit,
            ),

            // Loading Overlay
            if (_status == _ProductCreationStatus.loading)
              const CenteredProgressIndicator(),
          ],
        ),
      
    );
  }
}
