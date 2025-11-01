import 'dart:async';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/src/components/info_text.dart';
import 'package:wallet/src/models/deposit_details.dart';

class USSDTransactionCompletion extends StatefulWidget {
  final DepositDetails details;
  const USSDTransactionCompletion({super.key, required this.details});

  @override
  State<USSDTransactionCompletion> createState() =>
      _USSDTransactionCompletionState();
}

class _USSDTransactionCompletionState extends State<USSDTransactionCompletion> {
  Timer? _timer;
  late int _countdown;

  @override
  void initState() {
    super.initState();
    _countdown = widget.details.initialCountdownSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return timer.cancel();
      if (_countdown == 0) {
        setState(() => timer.cancel());
      } else {
        setState(() => _countdown--);
      }
    });
  }

  String _formatCountdown(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$sec';
  }

  Future<void> _handleClose() async {
    if (_countdown > 0) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Active Transaction"),
          content: const Text(
            "You have an ongoing transaction. Closing now will cancel it. Are you sure?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text("Cancel"),
            ),
            PrimaryActionButton(
              isExtended: false,
              onPressed: () => Navigator.pop(ctx, true),
              label: "Yes, Close",
            ),
          ],
        ),
      );
      if (confirm == true && mounted) Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExpired = _countdown <= 0;
    final ussdCode = widget.details.ussdCode;
    final depositAmount = widget.details.depositAmount;

    var codeSection = Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('please copy and dial the USSD code.'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isExpired
                  ? theme.colorScheme.error
                  : const Color(0xFF000000),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ussdCode,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: isExpired ? theme.colorScheme.error : null,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: isExpired
                    ? null
                    : () {
                        Clipboard.setData(ClipboardData(text: ussdCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('USSD code copied!')),
                        );
                      },
                child: Row(
                  children: [
                    Icon(
                      Icons.copy,
                      size: 24,
                      color: isExpired ? Colors.grey : theme.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Copy Code',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: isExpired ? Colors.grey : theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Text(
          isExpired
              ? 'Code expired.'
              : 'Code expires in ${_formatCountdown(_countdown)}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: isExpired ? theme.colorScheme.error : Colors.orange,
          ),
        ),
      ],
    );
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, r) {
        if (!didPop) _handleClose();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 24,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Amount to Receive: NLe ${depositAmount.toStringAsFixed(2)}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),

                InfoText(amount: widget.details.depositAmount),

                codeSection,

                PrimaryActionButton(label: 'Close', onPressed: _handleClose),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
