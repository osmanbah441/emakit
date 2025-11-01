import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

import 'components/components.dart';
import 'models/models.dart';

class CheckoutWalletCard extends StatefulWidget {
  const CheckoutWalletCard({
    super.key,
    required this.amountToPay,
    required this.onPaySuccess,
  });

  final double amountToPay;
  final VoidCallback onPaySuccess;

  @override
  State<CheckoutWalletCard> createState() => _CheckoutWalletCardState();
}

class _CheckoutWalletCardState extends State<CheckoutWalletCard> {
  double _balance = 0.0;
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

  Future<void> _fetchBalance() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final newBalance = await _repo.getBalance();
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
            final details = await _repo.addMoney(amount);
            return details;
          },
          onSuccess: (details) async {
            await Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (_) => USSDTransactionCompletion(
                  details: details as DepositDetails,
                ),
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
    if (_isPaying || _balance < widget.amountToPay) return;

    setState(() {
      _isPaying = true;
    });

    try {
      await _repo.pay(amount: widget.amountToPay);

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
    final canPay = _balance >= widget.amountToPay;

    return WalletCard(
      balance: _balance,
      isFetchBalance: _isLoading,
      actionSection: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _isPaying || _isLoading
            ? PrimaryActionButton.isLoadingProgress(
                label: _isPaying ? 'Processing Payment...' : 'Loading...',
              )
            : PrimaryActionButton(
                label: canPay ? 'Pay Now' : 'Insufficient Funds Add Cash',
                onPressed: _isLoading
                    ? null
                    : canPay
                    ? _handlePayment
                    : () => _showAddMoneyModal(context),
              ),
      ),
    );
  }
}
