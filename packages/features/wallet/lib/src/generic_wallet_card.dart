import 'package:flutter/material.dart';

import 'components/components.dart';
import 'models/models.dart';

class GenericWalletCard extends StatefulWidget {
  const GenericWalletCard({super.key, required this.walletId});
  final String walletId;

  @override
  State<GenericWalletCard> createState() => _GenericWalletCardState();
}

class _GenericWalletCardState extends State<GenericWalletCard> {
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

  void _showAddMoneyModal(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: _isLoading ? null : () => _showAddMoneyModal(context),
              icon: const Icon(Icons.phone_android),
              label: const Text('Add Money'),
            ),

            ElevatedButton.icon(
              onPressed: cashoutDisabled ? null : _handleCashout,
              icon: cashoutDisabled && _isCashingOut
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.swap_horiz),
              label: Text(_isCashingOut ? 'Processing...' : 'Cash out'),
            ),
          ],
        ),
      ),
    );
  }
}
