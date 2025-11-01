import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/models.dart';
import 'info_text.dart';

class CashoutModal extends StatefulWidget {
  final double availableBalance;
  final Future<void> Function(CashoutDetails details) onCashoutConfirm;

  const CashoutModal({
    super.key,
    required this.availableBalance,
    required this.onCashoutConfirm,
  });

  @override
  State<CashoutModal> createState() => _CashoutModalState();
}

class _CashoutModalState extends State<CashoutModal> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  MobileMoneyProvider? _provider;
  bool _isProcessing = false;

  static const double _feeRate = 0.015; // 1.5%

  double _amount = 0;
  double get _fee => _amount * _feeRate;
  double get _total => _amount + _fee;
  bool get _exceedsBalance => _total > widget.availableBalance && _amount > 0;

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isProcessing = true);

    final details = CashoutDetails(
      phoneNumber: _phoneController.text,
      provider: _provider!,
      amount: _amount,
      total: _total,
      fee: _fee,
    );

    try {
      await widget.onCashoutConfirm(details);
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Cashout (Balance: Le ${widget.availableBalance.toStringAsFixed(2)})',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixText: 'NLe ',
                ),
                onChanged: (value) => setState(() {
                  _amount = double.tryParse(value) ?? 0;
                }),
                validator: (v) {
                  final amount = double.tryParse(v ?? '');
                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount';
                  }
                  if (_exceedsBalance) {
                    return 'Exceeds available balance';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter phone number' : null,
              ),
              const SizedBox(height: 16),

              // Provider
              DropdownButtonFormField<MobileMoneyProvider>(
                decoration: InputDecoration(labelText: 'Mobile Money Provider'),
                items: MobileMoneyProvider.values
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (val) => setState(() => _provider = val),
                validator: (v) => v == null ? 'Select a provider' : null,
              ),

              const SizedBox(height: 16),

              InfoText(
                amount: _amount,
                text: 'Funds will reflect in your wallet within a few minutes.',
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: _isProcessing
                    ? PrimaryActionButton.isLoadingProgress()
                    : PrimaryActionButton(
                        label: 'Continue',
                        onPressed: _submitForm,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
