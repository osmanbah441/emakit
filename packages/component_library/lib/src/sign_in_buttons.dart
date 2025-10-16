import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final label = 'Sign in with Google';

    return isLoading
        ? ExtendedOutlineButton.isLoadingProgress(label: label)
        : ExtendedOutlineButton(
            onPressed: onPressed,
            label: label,
            icon: Image.asset(
              'assets/images/google_icon.png',
              height: 24,
              package: 'component_library',
            ),
          );
  }
}

class SignInWithAppleButton extends StatelessWidget {
  const SignInWithAppleButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final label = 'Sign in with Apple';
    return isLoading
        ? ExtendedOutlineButton.isLoadingProgress(label: label)
        : ExtendedOutlineButton(
            onPressed: onPressed,
            label: label,
            icon: Icon(Icons.apple, size: 24),
          );
  }
}
