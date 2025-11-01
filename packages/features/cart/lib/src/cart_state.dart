part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartLoading extends CartState {
  const CartLoading();
}

final class CartEmpty extends CartState {
  const CartEmpty();
}

final class CartFailure extends CartState {
  final String message;
  const CartFailure(this.message);
}

final class NotAuthenticated extends CartState {
  const NotAuthenticated();
}

final class CartSuccess extends CartState {
  final List<CartItem> items;
  final Set<String> updatingItems;

  const CartSuccess(this.items, {this.updatingItems = const {}});

  /// Return whether a specific item id is currently updating
  bool isUpdating(String id) => updatingItems.contains(id);

  /// Total number of items (sum of quantities)
  int get totalItemsInCart => items.fold(0, (sum, item) => sum + item.quantity);

  /// Number of selected items (sum of selected quantities)
  int get selectedItemsCount => items
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + item.quantity);

  /// Total price of selected items
  double get selectedItemsTotalPrice => items
      .where((item) => item.isSelected)
      .fold(0.0, (sum, item) => sum + item.lineTotal);

  /// Replace a single item by id with new quantity/isSelected.
  /// Returns a new CartSuccess with the list replaced and provided updatingItems (if any).
  CartSuccess replaceItem({
    required String id,
    int? quantity,
    bool? isSelected,
    Set<String>? updatingItems,
  }) {
    final updatedItems = List<CartItem>.from(items);
    final index = updatedItems.indexWhere((it) => it.id == id);
    if (index == -1) {
      // nothing to replace
      return CartSuccess(
        items,
        updatingItems: updatingItems ?? this.updatingItems,
      );
    }

    final old = updatedItems[index];

    final newQty = quantity ?? old.quantity;
    final newSelected = isSelected ?? old.isSelected;

    // create new CartItem manually (no copyWith)
    final newItem = CartItem(
      id: old.id,
      quantity: newQty,
      unitPrice: old.unitPrice,
      availableStock: old.availableStock,
      lineTotal: old.unitPrice * newQty,
      productName: old.productName,
      variantSignature: old.variantSignature,
      imageUrl: old.imageUrl,
      inStock: old.inStock,
      isSelected: newSelected,
    );

    updatedItems[index] = newItem;
    return CartSuccess(
      updatedItems,
      updatingItems: updatingItems ?? this.updatingItems,
    );
  }

  /// Remove item by id and return new CartSuccess (keeps updatingItems)
  CartSuccess removeItemById(String id, {Set<String>? updatingItems}) {
    final updatedItems = items.where((it) => it.id != id).toList();
    return CartSuccess(
      updatedItems,
      updatingItems: updatingItems ?? this.updatingItems,
    );
  }
}
