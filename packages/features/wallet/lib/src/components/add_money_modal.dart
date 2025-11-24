import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/src/components/info_text.dart';
import 'package:component_library/component_library.dart';
import 'package:wallet/src/models/models.dart';

class AddMoneyModal extends StatefulWidget {
  const AddMoneyModal({required this.onAddMoney, this.onSuccess, super.key});

  final Future<UssdFundTransferRequest> Function(double amount) onAddMoney;

  final void Function(UssdFundTransferRequest result)? onSuccess;

  @override
  State<AddMoneyModal> createState() => _AddMoneyModalState();
}

class _AddMoneyModalState extends State<AddMoneyModal> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  bool _isLoading = false;
  double _amount = 0.0;
  String? _error;

  void _onAmountChanged(String value) {
    final parsed = double.tryParse(value) ?? 0.0;
    setState(() => _amount = parsed > 999999 ? 999999 : parsed);
  }

  Future<void> _handleContinue() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountController.text);
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await widget.onAddMoney(amount);

      if (!mounted) return;
      Navigator.pop(context);

      widget.onSuccess?.call(result);
    } catch (e) {
      setState(
        () => _error =
            'Failed to initiate deposit. Check your internet connection and try again.',
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        24,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Add Money', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              onChanged: _onAmountChanged,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
                prefixText: 'NLe ',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                final num = double.tryParse(value ?? '');
                if (num == null) return 'Enter a valid number';
                if (num < 10) return 'Minimum is 10 NLe';
                if (num > 50000) return 'Maximum is 50,000 NLe';
                return null;
              },
            ),

            const SizedBox(height: 16),
            InfoText(
              amount: _amount,
              text: 'Only Africell Money and Orange Money are supported.',
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(
                _error!,
                textAlign: TextAlign.start,
                style: textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            const SizedBox(height: 16),
            if (_isLoading)
              PrimaryActionButton.isLoadingProgress()
            else
              PrimaryActionButton(
                label: 'Continue',
                onPressed: _handleContinue,
              ),

            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening Payment Terms...')),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    text: 'By continuing, you agree to our ',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    children: const [
                      TextSpan(
                        text: 'Payment Terms.',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
