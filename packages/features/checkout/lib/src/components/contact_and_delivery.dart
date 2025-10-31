import 'package:checkout/src/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactAndDelivery extends StatelessWidget {
  const ContactAndDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<CheckoutCubit>();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Contact",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter phone number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            Text(
              "Delivery Address",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<CheckoutCubit, CheckoutState>(
                    builder: (context, state) {
                      return DropdownButtonFormField<Address>(
                        isExpanded: true,
                        hint: const Text("Select Address "),
                        items: state.addresses
                            .map(
                              (address) => DropdownMenuItem<Address>(
                                value: address,
                                child: Text(
                                  "${address.label} - ${address.details}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (address) {
                          cubit.selectAddress(address);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: cubit.useCurrentLocation,
                  icon: const Icon(Icons.my_location),
                  tooltip: "use Current Location",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
