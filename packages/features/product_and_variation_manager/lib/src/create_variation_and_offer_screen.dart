import 'package:category_repository/category_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:product_and_variation_manager/src/components/add_variation_form.dart';
import 'package:product_repository/product_repository.dart';

enum _VariationCreationStatus {
  idle,
  loading,
  success,
  error,
}

class CreateVariationAndOfferScreen extends StatefulWidget {
  const CreateVariationAndOfferScreen({
    super.key,
    required this.productRepository,
    required this.categoryRepository,
    required this.productId,
    required String categoryId, required this.onManageOffer, 
  });

  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;
  final String productId;
  final VoidCallback onManageOffer;

  @override
  State<CreateVariationAndOfferScreen> createState() =>
      _CreateVariationAndOfferScreenState();
}

class _CreateVariationAndOfferScreenState
    extends State<CreateVariationAndOfferScreen> {
  _VariationCreationStatus _status = _VariationCreationStatus.idle;
   List<String> _imageUrls = [];

  void _submitVariation({
    required Map<String, String> selectedAttributes,
    required List<String> imageUrls,
    required double price,
    required int stock,
  }) async {
    setState(() {
      _status = _VariationCreationStatus.loading;
      _imageUrls = imageUrls;
    });

    try {
      await widget.productRepository.createVariationAndOffer(
        storeId: '9d7c0f1e-3a7b-40f0-8c5d-672e391b4c5a',
        productId: widget.productId,
        attributes: selectedAttributes,
        imageUrls: imageUrls,
        price: price,
        stock: stock,
      );

      // 2. Set state to success
      setState(() {
        _status = _VariationCreationStatus.success;
      });
      // Optionally handle navigation here, e.g., pop the screen
      // if (mounted) Navigator.of(context).pop();

    } catch (e) {
      // 3. Set state to error and show Snackbar
      setState(() {
        _status = _VariationCreationStatus.error;
      });

      if (mounted) {
        ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
          SnackBar(content: Text('Failed to create variation: ${e.toString()}')),
        );
      }
    
      setState(() {
        _status = _VariationCreationStatus.idle;
      });
    }
  }

  Future<_ProductAndCategory> _fetchData() async {
    final product =
        await widget.productRepository.getStoreProductById(widget.productId);
    if (product == null) {
      throw Exception('Failed to fetch product with ID ${widget.productId}');
    }
    final category = await widget.categoryRepository.productCategory(
      id: product.categoryId!,
    );

    if (category.isEmpty) {
      throw Exception('Failed to fetch category');
    }

    return _ProductAndCategory(product: product, category: category.first);
  }

  @override
  Widget build(BuildContext context) {
    // If successful, show the success screen/component
  
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<_ProductAndCategory>(
          future: _fetchData(),
          builder: (context, asyncSnapshot) {
            // Handle initial data fetching states (loading and error)
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              // Use CenteredProgressIndicator if available, otherwise default
              return const Center(child: CircularProgressIndicator());
            }

            if (asyncSnapshot.hasError) {
              return Center(child: Text('Error: ${asyncSnapshot.error}'));
            }

            final data = asyncSnapshot.data;
            if (data == null) {
              return const Center(child: Text('Product not found'));
            }

            // If the variation creation is loading, overlay the loading component
            if (_status == _VariationCreationStatus.loading) {
              return const _LoadingState();
            }

              if (_status == _VariationCreationStatus.success) {
      return AppSuccessView(
      title: "We're Reviewing this variation once accept we can set it live",
      content: ProductImageCarousel(imageUrls: _imageUrls, borderRadius: BorderRadius.circular(16),),
      actionLabel: 'Manage All Offers',
      onAction: widget.onManageOffer,
    );
    }


            // Otherwise, show the main form
            return AddVariationForm(
              attributeFields: data.category.variantFields,
              onSubmitted: _submitVariation,
            );
          },
        ),
      ),
    );
  }
}


class _ProductAndCategory {
  final StoreProduct product;
  final ProductCategory category;

  _ProductAndCategory({required this.product, required this.category});
}

/// Component for the Loading state
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Creating variation and offer...'),
        ],
      ),
    );
  }
}
