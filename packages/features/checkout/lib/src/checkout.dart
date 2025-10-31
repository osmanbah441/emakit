import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:component_library/component_library.dart';

import 'components/contact_and_delivery.dart';

class Address extends Equatable {
  final String id;
  final String label;
  final String details;

  const Address({required this.id, required this.label, required this.details});

  @override
  List<Object?> get props => [id, label, details];
}

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
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                children: [
                  const ContactAndDelivery(),

                  OrderSummarySection(
                    subtotal: '\$128.00',
                    shippingCost: '\$5.00',
                    taxes: '\$10.24',
                    total: '\$130.44',
                    discount: '-\$12.80 (WELCOME10)',
                  ),

                  WalletCard(
                    ownerName: '',
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
