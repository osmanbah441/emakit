import 'package:component_library/component_library.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../checkout_cubit.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Order Summary',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...state.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    AppNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(8),
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Qty: ${item.quantity}',
                            style: theme.textTheme.bodySmall,
                          ),
                          Text(
                            'Nle ${item.lineTotal.toStringAsFixed(2)}',
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Remove Item',
                      icon: Icon(
                        Icons.delete_outline,
                        color: theme.colorScheme.error,
                      ),
                      onPressed: () =>
                          context.read<CheckoutCubit>().unSelect(item.id),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 16),
            // TextRowComponent(
            //   label: 'subtotal',
            //   value: 'Nle ${state.subtotal.toStringAsFixed(2)}',
            // ),
            // TextRowComponent(
            //   label: 'Delivery Fees',
            //   value: 'Nle ${state.shipping.toStringAsFixed(2)}',
            // ),
            // TextRowComponent(
            //   label: 'tax',
            //   value: 'Nle ${state.taxAmount.toStringAsFixed(2)}}',
            // ),
            // const Divider(height: 16),
            TextRowComponent(
              label: 'Total',
              value: 'Nle ${state.total.toStringAsFixed(2)}',
              labelStyle: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              valueStyle: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        );
      },
    );
  }
}
