import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:component_library/component_library.dart';

/// --- MODEL ---
class Address extends Equatable {
  final String id;
  final String label;
  final String details;

  const Address({required this.id, required this.label, required this.details});

  @override
  List<Object?> get props => [id, label, details];
}

/// --- STATE ---
class CheckoutState extends Equatable {
  final List<Address> addresses;
  final Address? selectedAddress;

  const CheckoutState({this.addresses = const [], this.selectedAddress});

  CheckoutState copyWith({List<Address>? addresses, Address? selectedAddress}) {
    return CheckoutState(
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }

  @override
  List<Object?> get props => [addresses, selectedAddress ?? ""];
}

/// --- CUBIT ---
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit()
    : super(
        const CheckoutState(
          addresses: [
            Address(
              id: 'home',
              label: 'Home',
              details: '123 Blossom Street, Floral City, FL 12345',
            ),
            Address(
              id: 'work',
              label: 'Work',
              details: '456 Corporate Ave, Business Bay, NY 67890',
            ),
          ],
        ),
      );

  void selectAddress(Address? address) {
    emit(state.copyWith(selectedAddress: address));
  }

  void useCurrentLocation() {
    final current = const Address(
      id: 'gps',
      label: 'Current Location',
      details: 'Using your device location',
    );
    emit(state.copyWith(selectedAddress: current));
  }
}

/// --- UI ---
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckoutCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Checkout'), centerTitle: true),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            final cubit = context.read<CheckoutCubit>();
            final theme = Theme.of(context);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                children: [
                  // --- Delivery Contact ---
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                              labelText: 'Phone Number for Delivery',
                              hintText: '+1 (555) 123-4567',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We will use this number to contact you for delivery updates.",
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- Delivery Address ---
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Delivery Address",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<Address>(
                            isExpanded: true,
                            hint: const Text("Select an address"),
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
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            onPressed: cubit.useCurrentLocation,
                            icon: const Icon(Icons.my_location),
                            label: const Text(
                              "Add Address via Current Location",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  OrderSummarySection(
                    subtotal: '\$128.00',
                    shippingCost: '\$5.00',
                    taxes: '\$10.24',
                    total: '\$130.44',
                    discount: '-\$12.80 (WELCOME10)',
                  ),

                  WalletCard(
                    ownerName: 'John Doe',
                    balance: 150.75,
                    actionSection: Padding(
                      padding: const EdgeInsets.all(24),
                      child: PrimaryActionButton(
                        label: 'Pay with Wallet',
                        onPressed: () {},
                        icon: const Icon(Icons.account_balance_wallet),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
