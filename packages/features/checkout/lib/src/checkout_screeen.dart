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
class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = "";

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        if (state.isLoading) return const CenteredProgressIndicator();
        final userId = state.items.isEmpty ? "" : state.items.first.userId;
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a phone number';
                                  }
                                  return null;
                                },
                                controller: _phoneNumberController,
                                onChanged: (value) =>
                                    setState(() => _phoneNumber = value),
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
                        formKey: _formKey,
                        walletId: 'fac-k6HN5o5gSDgMnwWnoM8GJwqGZua',
                        userId: userId,
                        userPhoneNumber: _phoneNumber,
                        amountToPay: state.total,
                        onPaySuccess: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Payment successful!'),
                            ),
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
            ),
          ],
        );
      },
    );
  }
}
