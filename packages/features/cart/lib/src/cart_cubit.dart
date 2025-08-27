import 'package:dataconnect/dataconnect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState()) {
    _fetchCartItems();
  }

  // final _repo = DataConnect.instance.userCommerceRepository;

  void _fetchCartItems() async {
    // emit(state.copyWith(status: CartStatus.loading));

    // final cart = await _repo.fetchUserCart();

    // emit(state.copyWith(status: CartStatus.loaded, cart: cart));
  }

  void incrementItemQuantity(String itemId) async {
    // await _repo.incrementCartItemQuantity(itemId);
    // final updatedCart = await _repo.fetchUserCart();
    // emit(state.copyWith(cart: updatedCart));
  }

  void decrementItemQuantity(String itemId) async {
    // await _repo.decrementCartItemQuantity(itemId);
    // final updatedCart = await _repo.fetchUserCart();

    // emit(state.copyWith(cart: updatedCart));
  }

  void removeItem(String itemId) async {
    // await _repo.removeCartItem(itemId);
    // final updatedCart = await _repo.fetchUserCart();

    // emit(state.copyWith(cart: updatedCart));
  }

  /// Clears all items from the cart.
  Future<void> clearCart() async {
    // await _repo.clearCart();
    // final updatedCart = await _repo.fetchUserCart();

    // emit(state.copyWith(cart: updatedCart));
  }
}
