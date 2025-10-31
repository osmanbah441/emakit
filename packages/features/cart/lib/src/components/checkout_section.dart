import 'package:cart/src/cart_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutSection extends StatelessWidget {
  const CheckoutSection({super.key, this.onCheckoutTap});

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
        final isItemSelected = itemCount > 0;

        return Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              onPressed: isItemSelected ? onCheckoutTap : null,
              label: isItemSelected
                  ? 'Proceed to checkout ($itemCount items)'
                  : 'Select items to checkout',
            ),
          ],
        );
      },
    );
  }
}
