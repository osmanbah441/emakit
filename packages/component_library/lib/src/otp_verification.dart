import 'dart:async';

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({
    super.key,
    required this.mobileNumber,
    required this.onVerify,
    required this.onResend,
    this.countdownDuration = 60,
  });
  final String mobileNumber;
  final Future<void> Function(String otp) onVerify;
  final Future<void> Function() onResend;
  final int countdownDuration;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final _otpController = TextEditingController();
  Timer? _timer;
  int _countdown = 0;
  bool _isResendReady = false;
  bool _isVerifyLoading = false;
  bool _isResendLoading = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _countdown = widget.countdownDuration;
      _isResendReady = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        setState(() => _isResendReady = true);
        _timer?.cancel();
      }
    });
  }

  Future<void> _handleVerify() async {
    if (_isVerifyLoading) return;
    final otp = _otpController.text.trim();
    if (otp.length != 6) return;
    setState(() => _isVerifyLoading = true);
    try {
      await widget.onVerify(otp);
    } finally {
      if (mounted) {
        setState(() => _isVerifyLoading = false);
      }
    }
  }

  Future<void> _resendCode() async {
    if (_isResendLoading) return;
    setState(() => _isResendLoading = true);
    try {
      _otpController.clear();
      await widget.onResend();
      _startTimer();
    } finally {
      if (mounted) {
        setState(() => _isResendLoading = false);
      }
    }
  }

  bool _isVerifyButtonEnabled() {
    return _otpController.text.length == 6 &&
        !_isResendReady &&
        !_isVerifyLoading;
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool isLoading = _isVerifyLoading || _isResendLoading;

    final header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Enter code", style: textTheme.titleLarge),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
        ),
      ],
    );

    final subtitle = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("We sent a verification code to your phone number"),
        const SizedBox(height: 2),
        Text(widget.mobileNumber, style: textTheme.titleMedium),
      ],
    );

    final otpInput = TextFormField(
      controller: _otpController,
      autofocus: true,
      enabled: !isLoading,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: textTheme.titleMedium?.copyWith(letterSpacing: 12.0),
      inputFormatters: [
        LengthLimitingTextInputFormatter(6),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        filled: true,
        errorText: _isResendReady ? 'Verification code has expired.' : null,
      ),
      onChanged: (value) => (value.length == 6) ? _handleVerify() : null,
    );

    final timerOrResendButton = _isResendReady
        ? TextButton(
            onPressed: isLoading ? null : _resendCode,
            child: _isResendLoading
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Resend Code'),
          )
        : Text(
            'This code expires in: 00:${_countdown.toString().padLeft(2, '0')}',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          );

    final verifyButton = _isVerifyLoading
        ? ExtendedElevatedButton.isLoadingProgress()
        : ExtendedElevatedButton(
            label: 'Verify',
            onPressed: _isVerifyButtonEnabled() ? _handleVerify : null,
          );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            const SizedBox(height: 8),
            subtitle,
            const SizedBox(height: 16),
            otpInput,
            const SizedBox(height: 16),
            timerOrResendButton,
            const SizedBox(height: 16),
            verifyButton,
          ],
        ),
      ),
    );
  }
}
