import '../component_library.dart';
import 'package:flutter/material.dart';

class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator({
    super.key,
    this.title,
    this.message,
    this.onButtonTapped,
    this.buttonLabel,
    this.buttonIcon,
    this.titleIcon,
  });

  final String? title;
  final String? message;
  final String? buttonLabel;
  final Widget? buttonIcon;
  final VoidCallback? onButtonTapped;
  final Widget? titleIcon;

  const ExceptionIndicator.authentication({
    Key? key,
    required VoidCallback onLoginTapped,
    String? message,
  }) : this(
         key: key,
         title: 'User Authentication Required',
         titleIcon: const Icon(Icons.lock_person_outlined, size: 48),
         buttonIcon: const Icon(Icons.login_outlined),
         buttonLabel: 'Login',
         onButtonTapped: onLoginTapped,
         message: message ?? 'Please login to continue',
       );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleIcon ?? const Icon(Icons.error, size: 48),
            const SizedBox(height: 12),
            Text(
              title ?? 'Something when wrong',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              message ?? 'could not connect to server, check your connection',
              textAlign: TextAlign.center,
            ),
            if (onButtonTapped != null) const SizedBox(height: 24),
            if (onButtonTapped != null)
              ExtendedElevatedButton(
                onPressed: onButtonTapped,
                icon: buttonIcon ?? const Icon(Icons.refresh),
                label: buttonLabel ?? 'Try Again',
              ),
          ],
        ),
      ),
    );
  }
}
