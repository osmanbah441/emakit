import 'package:checkout/src/checkout_cubit.dart';
import 'package:component_library/component_library.dart'
    hide OrderSummarySection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cart_repository/cart_repository.dart';
import 'components/components.dart';

import 'package:wallet/wallet.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.cartRepository});

  final CartRepository cartRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout'), centerTitle: true),
      body: BlocProvider(
        create: (context) => CheckoutCubit(cartRepository),
        child: CheckoutView(),
      ),
    );
  }
}

@visibleForTesting
class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        if (state.isLoading) return const CenteredProgressIndicator();
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          spacing: 16,
                          children: [
                            Text(
                              'This phone number will be used to contack you to help us delivery you items',
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone number',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    CheckoutWalletCard(
                      amountToPay: state.total,
                      onPaySuccess: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Payment successful!')),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    OrderSummarySection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
