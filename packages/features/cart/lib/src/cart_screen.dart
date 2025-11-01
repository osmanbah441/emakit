import 'package:cart/src/cart_cubit.dart';
import 'package:cart/src/components/checkout_section.dart';
import 'package:cart/src/components/cart_item_card.dart';
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
                CartSuccess() => _CartList(
                  state: state,
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
  const _CartList({required this.state, this.onCheckoutTap});

  final CartSuccess state;
  final VoidCallback? onCheckoutTap;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return Column(
      children: [
        CheckoutSection(onCheckoutTap: onCheckoutTap),
        Expanded(
          child: ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (_, i) {
              final item = state.items[i];
              final isUpdating = state.isUpdating(item.id);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Opacity(
                  opacity: isUpdating ? 0.7 : 1.0,
                  child: IgnorePointer(
                    ignoring: false,
                    child: CartItemCard(
                      imageUrl: item.imageUrl,
                      title: item.productName,
                      lineTotalPrice: item.lineTotal,
                      unitPrice: item.unitPrice,
                      inStock: item.inStock,
                      onTap: () {},
                      isSelected: item.isSelected,
                      onSelect: isUpdating
                          ? (_) {}
                          : (isSelected) => cubit.updateItem(
                              item.id,
                              isSelected: isSelected,
                            ),
                      quantity: item.quantity,
                      onIncrement: isUpdating
                          ? () {}
                          : () => cubit.updateItem(
                              item.id,
                              quantity: item.quantity + 1,
                            ),
                      onDecrement: isUpdating
                          ? () {}
                          : () {
                              if (item.quantity == 1) {
                                cubit.removeItem(item.id);
                                return;
                              }

                              cubit.updateItem(
                                item.id,
                                quantity: item.quantity - 1,
                              );
                            },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
