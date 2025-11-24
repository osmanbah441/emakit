import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:cart_repository/cart_repository.dart';

part 'buyer_product_details_state.dart';

class BuyerProductDetailsCubit extends Cubit<BuyerProductDetailsState> {
  BuyerProductDetailsCubit({
    required ProductRepository productRepository,
    required CartRepository cartRepository,
    required UserRepository userRepository,
    required String variantId,
  }) : _productRepository = productRepository,
       _cartRepository = cartRepository,
       _userRepository = userRepository,
       _variantId = variantId,
       super(const BuyerProductDetailsLoading()) {
    _loadProductDetails();
  }

  final ProductRepository _productRepository;
  final CartRepository _cartRepository;
  final UserRepository _userRepository;
  final String _variantId;

  Future<void> _loadProductDetails() async {
    emit(const BuyerProductDetailsLoading());
    try {
      final product = await _productRepository.getBuyerProductDetails(
        variantId: _variantId,
      );

      product as BuyerProductDetails;

      ProductVariation? variant;
      if (product.variants.isNotEmpty) {
        variant = product.variants.firstWhere(
          (v) => v.id == _variantId,
          orElse: () => product.variants.first,
        );
      }

      emit(
        BuyerProductDetailsLoaded(product: product, selectedVariant: variant),
      );
    } catch (e) {
      emit(BuyerProductDetailsError(e.toString()));
    }
  }

  /// Change the currently selected variant
  void selectVariant(ProductVariation variant) {
    if (state is! BuyerProductDetailsLoaded) return;
    final loaded = state as BuyerProductDetailsLoaded;
    emit(loaded.copyWith(selectedVariant: variant));
  }

  /// Add selected variant to cart
  Future<void> addToCart(String offerId) async {
    if (state is! BuyerProductDetailsLoaded) return;
    final currentState = state as BuyerProductDetailsLoaded;
    final variant = currentState.selectedVariant;
    if (variant == null) return;

    try {
      if (_userRepository.currentUser == null) {
        throw AuthException('auth required');
      }

      await _cartRepository.addItem(variantId: variant.id, offerId: offerId);
    } on AuthException catch (_) {
      emit(BuyerProductDetailsError('Authentication required'));
    }
  }
}
