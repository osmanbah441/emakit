import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

import 'components/components.dart';
import 'models/models.dart';

class WithdrawalWalletCard extends StatefulWidget {
  const WithdrawalWalletCard({super.key, required this.walletId});
  final String walletId;

  @override
  State<WithdrawalWalletCard> createState() => _WithdrawalWalletCardState();
}

class _WithdrawalWalletCardState extends State<WithdrawalWalletCard> {
  // 1. Updated state variable to use the Balance object.
  Balance? _balance;
  bool _isLoading = true;
  bool _isCashingOut = false;
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

  void _handleCashout() async {
    if (_isCashingOut) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return CashoutModal(
          availableBalance: _balance!.amount,
          onCashoutConfirm: (details) async {
            setState(() {
              _isCashingOut = true;
            });

            try {
              await _repo.mobileCashOut(
                walletId: widget.walletId,
                phoneNumber: details.phoneNumber,
                provider: details.provider,
                amount: details.total,
              );

              if (context.mounted) {
                showDialog<void>(
                  context: context,
                  builder: (context) => CashoutSuccessDialog(
                    amount: details.amount,
                    phoneNumber: details.phoneNumber,
                  ),
                );
              }
            } on CashoutFailedException catch (e) {
              _showErrorSnackbar(e.message);
              if (context.mounted) {
                Navigator.pop(context, false);
              }
            } catch (e) {
              _showErrorSnackbar('Cashout failed due to an unexpected error.');
              if (context.mounted) {
                Navigator.pop(context, false);
              }
            } finally {
              setState(() {
                _isCashingOut = false;
              });

              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
        );
      },
    );

    await _fetchBalance();
  }

  @override
  Widget build(BuildContext context) {
    final cashoutDisabled = _isLoading || _isCashingOut || _balance == null;

    return WalletCard(
      balance: _balance,
      isFetchBalance: _isLoading,
      actionSection: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: PrimaryActionButton(
          label: 'Withdraw Funds',
          onPressed: cashoutDisabled ? null : _handleCashout,
        ),
      ),
    );
  }
}
