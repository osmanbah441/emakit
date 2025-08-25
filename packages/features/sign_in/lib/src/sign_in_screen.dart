import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'sign_in_cubit.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.onSignInSucessful});

  final VoidCallback onSignInSucessful;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(),
      child: SignInView(onSignInSucessful: onSignInSucessful),
    );
  }
}

@visibleForTesting
class SignInView extends StatefulWidget {
  const SignInView({super.key, required this.onSignInSucessful});

  final VoidCallback onSignInSucessful;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  // Helper to get the full international number
  String get _fullPhoneNumber => '+232${_phoneNumberController.text.trim()}';

  String get _formatedPhoneNumber {
    final number = _phoneNumberController.text.trim();
    return '+232\t ${number.substring(0, 2)}\t ${number.substring(2)}';
  }

  void _showOtpDialog(BuildContext context, SignInCubit cubit) async {
    await showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: OtpVerification(
          mobileNumber: _formatedPhoneNumber,
          onVerify: cubit.verifyOtp,
          onResend: () => cubit.resendOtp(_fullPhoneNumber),
        ),
      ),
    );
  }

  void _submitPhone(SignInCubit cubit) {
    if (_formKey.currentState!.validate()) {
      cubit.continueWithMobile(_fullPhoneNumber);
    }
  }

  String _mapErrorToMessage(SignInSubmissionStatus status) {
    switch (status) {
      case SignInSubmissionStatus.failedOtpVerification:
        return "Invalid OTP. Please try again.";
      case SignInSubmissionStatus.networkError:
        return "Network error. Check your connection.";
      case SignInSubmissionStatus.invalidPhoneNumber:
        return "Invalid phone number.";
      case SignInSubmissionStatus.googleSignInError:
        return "Google sign-in was cancelled or failed.";
      default:
        return "An unexpected error occurred.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status.isAwaitingOtp) {
          _showOtpDialog(context, context.read<SignInCubit>());
        }
        if (state.status.isSuccess) {
          // Ensure dialog is closed before navigating
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          widget.onSignInSucessful();
        }
        if (state.status.hasError) {
          final error = _mapErrorToMessage(state.status);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(error)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignInCubit>();
        final textTheme = Theme.of(context).textTheme;

        final bool isLoading = state.status.isInProgress;
        final bool isPhoneLoading =
            isLoading && state.method == SignInMethod.phone;
        final bool isGoogleLoading =
            isLoading && state.method == SignInMethod.google;

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 50),
                const SizedBox(height: 24),
                Text('Login to Salone Bazaar', style: textTheme.titleLarge),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: PhoneNumberInputField(
                    controller: _phoneNumberController,
                  ),
                ),
                const SizedBox(height: 16),
                if (isPhoneLoading)
                  ExtendedElevatedButton.isLoadingProgress(
                    label: 'Continue with Mobile',
                  )
                else
                  ExtendedElevatedButton(
                    label: 'Continue with Mobile',
                    icon: const Icon(Icons.phone),
                    onPressed: isLoading ? null : () => _submitPhone(cubit),
                  ),
                const SizedBox(height: 16),
                Row(
                  // spacing: 16,
                  children: [
                    Expanded(child: const Divider(endIndent: 16, indent: 32)),
                    Text('or', style: textTheme.titleMedium),
                    Expanded(child: const Divider(endIndent: 32, indent: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                if (isGoogleLoading)
                  ExtendedOutlineButton.isLoadingProgress(
                    label: 'Sign in with Google',
                  )
                else
                  ExtendedOutlineButton(
                    onPressed: isLoading ? null : cubit.continueWithGoogle,
                    label: 'Sign in with Google',
                    icon: Image.asset(
                      'assets/images/google_icon.png',
                      height: 32,
                      package: 'component_library',
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
