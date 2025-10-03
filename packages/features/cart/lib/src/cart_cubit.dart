// cart_cubit.dart
import 'dart:async';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;
  final UserRepository _userRepository;
  late StreamSubscription<UserInfo?> _userSubscription;

  CartCubit({
    required CartRepository cartRepository,
    required UserRepository userRepository,
  }) : _cartRepository = cartRepository,
       _userRepository = userRepository,
       super(CartLoading()) {
    _userSubscription = _userRepository.onUserChanges.listen((user) {
      if (user == null) {
        emit(NotAuthenticated());
      } else {
        loadCart();
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final items = _cartRepository.getItems();
      if (items.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartSuccess(items));
      }
    } catch (e) {
      emit(CartFailure('Failed to load cart: $e'));
    }
  }

  Future<void> toggleItemSelection(String productId) async {
    final currentState = state;
    if (currentState is! CartSuccess) return;

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      if (productId == 'fail') {
        throw Exception('Failed to update selection.');
      }
      _cartRepository.toggleItemSelection(productId);
      loadCart();
    } catch (e) {
      emit(CartFailure('Failed to update selection: $e'));
    }
  }

  Future<void> incrementQuantity(String productId) async {
    final currentState = state;
    if (currentState is! CartSuccess) return;

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      _cartRepository.incrementQuantity(productId);
      loadCart();
    } catch (e) {
      emit(CartFailure('Failed to increment quantity: $e'));
    }
  }

  Future<void> decrementQuantity(String productId) async {
    final currentState = state;
    if (currentState is! CartSuccess) return;

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      _cartRepository.decrementQuantity(productId);
      loadCart();
    } catch (e) {
      emit(CartFailure('Failed to decrement quantity: $e'));
    }
  }

  Future<void> removeItem(String productId) async {
    final currentState = state;
    if (currentState is! CartSuccess) return;

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      _cartRepository.removeItem(productId);
      loadCart();
    } catch (e) {
      emit(CartFailure('Failed to remove item: $e'));
    }
  }
}
