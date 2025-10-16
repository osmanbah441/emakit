import 'package:cart/src/cart_cubit.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:user_repository/user_repository.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
    this.onCheckoutTap,
    required this.onLoginTapped,
  });

  final VoidCallback? onCheckoutTap;
  final VoidCallback onLoginTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(
        cartRepository: CartRepository.instance,
        userRepository: UserRepository.instance,
      ),
      child: CartView(
        onCheckoutTap: onCheckoutTap,
        onLoginTapped: onLoginTapped,
      ),
    );
  }
}

@visibleForTesting
class CartView extends StatelessWidget {
  const CartView({super.key, this.onCheckoutTap, required this.onLoginTapped});

  final VoidCallback? onCheckoutTap;
  final VoidCallback onLoginTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return switch (state) {
                CartLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                CartFailure(message: final message) => Center(
                  child: Text('Error: $message'),
                ),
                CartEmpty() => const Center(
                  child: Text(
                    'Your Salone Bazaar Cart is empty.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                NotAuthenticated() => ExceptionIndicator.authentication(
                  onLoginTapped: onLoginTapped,
                  message: "Please login to view your cart items",
                ),
                CartSuccess(items: final items) => _CartList(
                  items: items,
                  onCheckoutTap: onCheckoutTap,
                ),
              };
            },
          ),
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList({required this.items, this.onCheckoutTap});

  final List<CartItem> items;
  final VoidCallback? onCheckoutTap;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) {
              final item = items[i];
              final product = item.product;
              final inStock = product.stockQuantity > 0;

              return Stack(
                children: [
                  ItemListCard(
                    imageUrl: product.imageUrls.first,

                    title: product.getDisplayName(item.productName),
                    price: product.price,
                    listPrice: product.listPrice,
                    subtitle: Text(
                      inStock ? "In Stock" : "Out of Stock",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: inStock ? Colors.green : Colors.red,
                      ),
                    ),
                    onTap: () {},
                    action: QuantitySelector(
                      quantity: item.quantity,
                      onIncrement: () => cubit.incrementQuantity(product.id),
                      onDecrement: item.quantity == 1
                          ? () => cubit.removeItem(product.id)
                          : () => cubit.decrementQuantity(product.id),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Checkbox(
                      value: item.isSelected,
                      onChanged: (_) => cubit.toggleItemSelection(product.id),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        _CheckoutSection(onCheckoutTap: onCheckoutTap),
      ],
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  const _CheckoutSection({this.onCheckoutTap});

  final VoidCallback? onCheckoutTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocSelector<CartCubit, CartState, (double, int)>(
      selector: (state) {
        if (state is CartSuccess) {
          return (state.selectedItemsTotalPrice, state.selectedItemsCount);
        }
        return (0.0, 0);
      },
      builder: (context, data) {
        final (subtotal, itemCount) = data;
        return Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal", style: textTheme.titleLarge),
                Text(
                  "Nle ${subtotal.toStringAsFixed(2)}",
                  style: textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            PrimaryActionButton(
              onPressed: itemCount > 0 ? onCheckoutTap : null,
              label: 'Proceed to checkout ($itemCount items)',
            ),
          ],
        );
      },
    );
  }
}
