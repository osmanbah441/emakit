import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

import 'components/components.dart';
import 'models/models.dart';

class CheckoutWalletCard extends StatefulWidget {
  const CheckoutWalletCard({
    super.key,
    required this.formKey,
    required this.amountToPay,
    required this.onPaySuccess,
    required this.walletId,
    required this.userId,
    required this.userPhoneNumber,
    this.cartItemId,
  });

  final double amountToPay;
  final VoidCallback onPaySuccess;
  final String walletId;
  final String userId;
  final String userPhoneNumber;
  final String? cartItemId;
  final GlobalKey<FormState> formKey;

  @override
  State<CheckoutWalletCard> createState() => _CheckoutWalletCardState();
}

class _CheckoutWalletCardState extends State<CheckoutWalletCard> {
  Balance? _balance;
  bool _isLoading = true;
  bool _isPaying = false;
  final _repo = WalletRepository.instance;

  @override
  void initState() {
    super.initState();
    _fetchBalance();
  }

  void _showErrorSnackbar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  // 2. Updated to handle the Balance object returned from the repository.
  Future<void> _fetchBalance() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Assuming _repo.getBalance() now returns Future<Balance>
      final newBalance = await _repo.getBalance(widget.walletId);
      setState(() {
        _balance = newBalance;
      });
    } catch (e) {
      debugPrint('Failed to fetch balance: $e');
      _showErrorSnackbar('Something went wrong, check your internet.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAddMoneyModal(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return AddMoneyModal(
          onAddMoney: (amount) async {
            final details = await _repo.mobileCashIn(amount, widget.walletId);
            return details;
          },
          onSuccess: (details) async {
            await Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (_) => USSDTransactionCompletion(details: details),
              ),
            );
            await _fetchBalance();

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  Future<void> _handlePayment() async {
    if (!widget.formKey.currentState!.validate()) return;
    if (_isPaying || _balance!.amount < widget.amountToPay) return;

    setState(() {
      _isPaying = true;
    });

    try {
      await _repo.checkout(
        userId: widget.userId,
        userWalletId: widget.walletId,
        userPhoneNumber: widget.userPhoneNumber,
        cartItemId: widget.cartItemId,
      );

      await _fetchBalance();
      widget.onPaySuccess();
    } on PaymentFailedException catch (e) {
      _showErrorSnackbar(e.message);
    } catch (e) {
      _showErrorSnackbar('An unexpected error occurred. Please try again.');
    } finally {
      setState(() {
        _isPaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasProduct = widget.amountToPay > 0;
    final canPay =
        _balance != null &&
        _balance!.amount >= widget.amountToPay &&
        hasProduct;

    return WalletCard(
      balance: _balance,
      isFetchBalance: _isLoading,
      actionSection: _balance == null
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: _isPaying || _isLoading
                  ? PrimaryActionButton.isLoadingProgress(
                      label: _isPaying ? 'Processing Payment...' : 'Loading...',
                    )
                  : PrimaryActionButton(
                      label: canPay
                          ? 'Pay Now'
                          : !hasProduct
                          ? ''
                          : 'Insufficient Funds Add Cash',
                      onPressed: !hasProduct
                          ? null
                          : canPay
                          ? _handlePayment
                          : () => _showAddMoneyModal(context),
                    ),
            ),
    );
  }
}
