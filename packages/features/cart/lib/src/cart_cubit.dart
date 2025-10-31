import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;
  final UserRepository _userRepository;
  late final StreamSubscription<UserInfo?> _userSubscription;

  // Track which items are currently being updated
  final Set<String> _updatingItems = {};

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
        _loadCart();
      }
    });
  }

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    return super.close();
  }

  Future<void> _loadCart() async {
    try {
      final items = await _cartRepository.getItems();
      if (items.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartSuccess(items, updatingItems: _updatingItems));
      }
    } catch (e) {
      emit(CartFailure('Failed to load cart: $e'));
    }
  }

  /// Update an item (quantity and/or selection) — optimistic update + background sync.
  Future<void> updateItem(String id, {int? quantity, bool? isSelected}) async {
    final currentState = state;
    if (currentState is! CartSuccess) return;
    if (_updatingItems.contains(id)) return;
    _updatingItems.add(id);

    // Emit optimistic update: replace item locally using state helper and include updatingItems set
    final optimisticState = currentState.replaceItem(
      id: id,
      quantity: quantity,
      isSelected: isSelected,
      updatingItems: _updatingItems,
    );
    emit(optimisticState);

    try {
      // perform backend update (don't await reloading unless failure)
      await _cartRepository.update(
        id,
        quantity: quantity,
        isSelected: isSelected,
      );

      // After backend success, refresh authoritative list
      final items = await _cartRepository.getItems();
      emit(CartSuccess(items, updatingItems: _updatingItems));
    } catch (e) {
      // on failure, emit failure and reload clean state
      emit(CartFailure('Failed to update cart: $e'));
      await _loadCart();
    } finally {
      // remove updating flag and re-emit current success state with updated updatingItems
      _updatingItems.remove(id);
      if (state is CartSuccess) {
        emit(
          CartSuccess(
            (state as CartSuccess).items,
            updatingItems: _updatingItems,
          ),
        );
      }
    }
  }

  /// Remove an item (calls repository and reloads)
  Future<void> removeItem(String id) async {
    final currentState = state;
    if (currentState is! CartSuccess) return;

    final optimistic = currentState.removeItemById(
      id,
      updatingItems: _updatingItems,
    );
    emit(optimistic);

    try {
      await _cartRepository.removeItem(id);
      final items = await _cartRepository.getItems();
      emit(
        items.isEmpty
            ? CartEmpty()
            : CartSuccess(items, updatingItems: _updatingItems),
      );
    } catch (e) {
      print(e);
      emit(CartFailure('Failed to remove item: $e'));
      // await _loadCart();
    }
  }
}
