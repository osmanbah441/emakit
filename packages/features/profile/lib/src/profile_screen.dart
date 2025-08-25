import 'package:bloc/bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:user_repository/user_repository.dart';
import 'package:address_repository/address_repository.dart';
import 'package:payment_repository/payment_repository.dart';

// --- 1. State ---

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserInfo? user;
  final List<Address> addresses;
  final List<PaymentMethod> paymentMethods;
  final String? error;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.addresses = const [],
    this.paymentMethods = const [],
    this.error,
  });

  // Business logic getters for UI
  bool get canAddAddress => addresses.length < 3;
  bool get canAddPaymentMethod => paymentMethods.length < 5;

  ProfileState copyWith({
    ProfileStatus? status,
    UserInfo? user,
    List<Address>? addresses,
    List<PaymentMethod>? paymentMethods,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      addresses: addresses ?? this.addresses,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, addresses, paymentMethods, error];
}

// --- 2. Cubit ---

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;
  final AddressRepository _addressRepository;
  final PaymentRepository _paymentRepository;

  ProfileCubit({
    required UserRepository userRepository,
    required AddressRepository addressRepository,
    required PaymentRepository paymentRepository,
  }) : _userRepository = userRepository,
       _addressRepository = addressRepository,
       _paymentRepository = paymentRepository,
       super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final user = _userRepository.currentUser;
    if (user == null) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          error: 'User not logged in.',
        ),
      );
      return;
    }

    try {
      // Fetch all data in parallel
      final results = await Future.wait([
        _addressRepository.getAddresses(),
        _paymentRepository.getPaymentMethods(),
      ]);
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          user: user,
          addresses: results[0] as List<Address>,
          paymentMethods: results[1] as List<PaymentMethod>,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure, error: e.toString()));
    }
  }

  Future<void> addAddress({
    required String street,
    required String city,
  }) async {
    if (!state.canAddAddress) return;
    try {
      await _addressRepository.addAddress(
        streetAddress: street,
        city: city,
        latitude: 0.0, // Placeholder
        longitude: 0.0, // Placeholder
      );
      await loadProfile();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addMobileMoneyPayment({
    required String provider,
    required String phoneNumber,
  }) async {
    if (!state.canAddPaymentMethod) return;
    try {
      await _paymentRepository.addMobileMoneyPayment(
        provider: provider,
        phoneNumber: phoneNumber,
      );
      await loadProfile();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addCardPayment({
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) async {
    if (!state.canAddPaymentMethod) return;
    try {
      await _paymentRepository.addCardPayment(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cvv: cvv,
      );
      await loadProfile();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      await _addressRepository.deleteAddress(addressId);
      loadProfile(); // Reload to reflect changes
    } catch (e) {
      // Optionally emit a failure state with an error message
    }
  }

  Future<void> setDefaultAddress(String addressId) async {
    try {
      await _addressRepository.updateAddress(
        addressId: addressId,
        isDefault: true,
      );
      loadProfile(); // Reload to reflect changes
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deletePaymentMethod(String paymentMethodId) async {
    try {
      await _paymentRepository.deletePaymentMethod(paymentMethodId);
      loadProfile(); // Reload to reflect changes
    } catch (e) {
      // Handle error
    }
  }

  Future<void> linkGoogleAccount() async {
    // Implementation would call user repository and then reload the profile
  }
}

// --- 3. UI ---

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        userRepository: UserRepository.instance,
        addressRepository: AddressRepository.instance,
        paymentRepository: PaymentRepository.instance,
      )..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading ||
              state.status == ProfileStatus.initial) {
            return const CenteredProgressIndicator();
          }

          if (state.status == ProfileStatus.failure || state.user == null) {
            return Center(
              child: Text(state.error ?? 'An unknown error occurred.'),
            );
          }

          final user = state.user!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _UserInfoSection(user: user),
                const SizedBox(height: 24),
                _ExpandableSection(
                  title: 'Payment Methods',
                  icon: Icons.payment,
                  items: state.paymentMethods,
                  canAddNew: state.canAddPaymentMethod,
                  itemBuilder: (context, item) =>
                      _PaymentMethodTile(method: item as PaymentMethod),
                  onAddNew: () => _showAddPaymentDialog(context),
                ),
                const SizedBox(height: 16),
                _ExpandableSection(
                  title: 'Shipping Addresses',
                  icon: Icons.local_shipping,
                  items: state.addresses,
                  canAddNew: state.canAddAddress,
                  itemBuilder: (context, item) =>
                      _AddressTile(address: item as Address),
                  onAddNew: () => _showAddAddressDialog(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAddPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: const _AddPaymentMethodDialog(),
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: const _AddAddressDialog(),
      ),
    );
  }
}

class _UserInfoSection extends StatelessWidget {
  final UserInfo user;

  const _UserInfoSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 64,
          backgroundImage: user.photoURL != null
              ? NetworkImage(user.photoURL!)
              : null,
          child: user.photoURL == null
              ? const Icon(Icons.person, size: 64)
              : null,
        ),
        const SizedBox(height: 10),
        Text(
          user.displayName ?? 'No Name',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 30),
        ListTile(
          title: const Text('Phone Number'),
          subtitle: Text(user.phoneNumber ?? 'Not provided'),
          leading: const Icon(Icons.phone),
        ),
        ListTile(
          title: const Text('Google Account'),
          subtitle: Text(user.email ?? 'Not linked'),
          leading: Image.asset(
            'assets/images/google_icon.png',
            package: 'component_library',
            width: 24,
            height: 24,
          ),
          trailing: user.email == null
              ? TextButton(
                  onPressed: () =>
                      context.read<ProfileCubit>().linkGoogleAccount(),
                  child: const Text('Link'),
                )
              : null,
        ),
      ],
    );
  }
}

class _ExpandableSection extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<dynamic> items;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final VoidCallback onAddNew;
  final bool canAddNew;

  const _ExpandableSection({
    required this.title,
    required this.icon,
    required this.items,
    required this.itemBuilder,
    required this.onAddNew,
    required this.canAddNew,
  });

  @override
  State<_ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<_ExpandableSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Row(
                children: [
                  Icon(widget.icon),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                ],
              ),
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    const Divider(),
                    if (widget.items.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text('Nothing added yet.'),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) =>
                            widget.itemBuilder(context, widget.items[index]),
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                      ),
                    const Divider(),
                    if (widget.canAddNew)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: widget.onAddNew,
                          icon: const Icon(Icons.add),
                          label: const Text('ADD NEW'),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final PaymentMethod method;
  const _PaymentMethodTile({required this.method});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String title;
    String subtitle;

    switch (method) {
      case final MobileMoneyPayment m:
        icon = Icons.phone_android;
        title = 'Mobile Money (${m.provider.name})';
        subtitle = m.phoneNumber;
        break;
      case final CardPayment c:
        icon = Icons.credit_card;
        title = '${c.brand} Card';
        subtitle = '**** **** **** ${c.last4Digits}';
        break;
      default:
        return const SizedBox.shrink();
    }

    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'delete') {
            context.read<ProfileCubit>().deletePaymentMethod(method.id);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(value: 'delete', child: Text('Remove')),
        ],
      ),
    );
  }
}

class _AddressTile extends StatelessWidget {
  final Address address;
  const _AddressTile({required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on_outlined),
      title: Row(
        children: [
          Expanded(child: Text(address.streetAddress)),
          if (address.isDefault)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Chip(
                label: const Text('Default'),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                labelStyle: Theme.of(context).textTheme.bodySmall,
              ),
            ),
        ],
      ),
      subtitle: Text(address.city),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'delete') {
            context.read<ProfileCubit>().deleteAddress(address.id);
          } else if (value == 'setDefault') {
            context.read<ProfileCubit>().setDefaultAddress(address.id);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          if (!address.isDefault)
            const PopupMenuItem<String>(
              value: 'setDefault',
              child: Text('Set as Default'),
            ),
          const PopupMenuItem<String>(value: 'delete', child: Text('Remove')),
        ],
      ),
    );
  }
}

// --- Dialog Widgets ---

class _AddAddressDialog extends StatefulWidget {
  const _AddAddressDialog();

  @override
  State<_AddAddressDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<_AddAddressDialog> {
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Address'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _streetController,
            decoration: const InputDecoration(labelText: 'Street Address'),
          ),
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(labelText: 'City'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<ProfileCubit>().addAddress(
              street: _streetController.text,
              city: _cityController.text,
            );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _AddPaymentMethodDialog extends StatelessWidget {
  const _AddPaymentMethodDialog();

  @override
  Widget build(BuildContext context) {
    // A simple dialog to choose which type of payment method to add.
    // A more complex implementation could use a single dialog with a PageView.
    return AlertDialog(
      title: const Text('Add Payment Method'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Mobile Money'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Show a specific dialog for Mobile Money
            },
          ),
          ListTile(
            title: const Text('Credit/Debit Card'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Show a specific dialog for Card
            },
          ),
        ],
      ),
    );
  }
}
