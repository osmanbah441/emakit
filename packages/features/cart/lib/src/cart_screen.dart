import 'package:component_library/component_library.dart';
import 'package:component_library/src/primary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.onCheckoutTap});

  final Function(BuildContext context) onCheckoutTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CartCubit(),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return switch (state.status) {
              CartStatus.initial || CartStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              CartStatus.error => Center(
                child: Text('Error: ${state.errorMessage}'),
              ),

              CartStatus.loaded => CartView(onCheckoutTap: onCheckoutTap),
            };
          },
        ),
      ),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key, required this.onCheckoutTap});

  final Function(BuildContext context) onCheckoutTap;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cart = state.cart;
        if (cart == null || cart.items.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        }
        final items = cart.items;
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ...items.map((item) {
              return CartItemCard(
                imageUrl: item.product.imageUrls.first,
                title: item.title,
                totalPrice: item.totalPrice,
                currentQuantity: item.quantity,
                attributes: item.product.attributes,
                onDecrement: () {
                  if (item.quantity == 1) {
                    cubit.removeItem(item.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item removed from cart')),
                    );
                    return;
                  }
                  cubit.decrementItemQuantity(item.id);
                },
                onIncrement: () {
                  if (item.product.stockQuantity <= item.quantity) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No more stock available')),
                    );
                    return;
                  }
                  cubit.incrementItemQuantity(item.id);
                },
              );
            }),
            const SizedBox(height: 20.0),

            // Order Summary Section
            OrderSummarySection(
              subtotal: '\$${cart.subTotal.toStringAsFixed(2)}',
              shippingCost: 'Free',
              taxes: '\$${cart.taxes.toStringAsFixed(2)}',
              total: '\$${cart.total.toStringAsFixed(2)}',
            ),
            PrimaryActionButton(
              onPressed: () => onCheckoutTap(context),
              label: 'Proceed to Checkout',
            ),
          ],
        );
      },
    );
  }
}
