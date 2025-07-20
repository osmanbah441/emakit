import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'sign_in_cubit.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.onSignInSucessful});

  final Function(BuildContext) onSignInSucessful;

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

  final Function(BuildContext) onSignInSucessful;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _mobileNumberController = TextEditingController();
  final _otpController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _showOtpDialog(SignInCubit cubit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('Verify Your Phone Number'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text("We've sent a code to ${_mobileNumberController.text}."),
              const SizedBox(height: 16),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                decoration: const InputDecoration(
                  hintText: 'Enter 6-digit OTP',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Edit Phone'),
            ),
            TextButton(
              onPressed: () {
                cubit.verifyOtp(_otpController.text.trim());
                Navigator.of(context).pop();
              },
              child: const Text('Verify'),
            ),
          ],
        );
      },
    );
  }

  void _submitPhone(SignInCubit cubit) {
    if (_formKey.currentState!.validate()) {
      cubit.continueWithMobile(_mobileNumberController.text.trim());
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
        return "Google sign-in cancelled.";
      default:
        return "Something went wrong.";
    }
  }

  void _showNameDialog(SignInCubit cubit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('Please Enter you name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Enter your name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                cubit.updateDisplayName(_nameController.text.trim());
                Navigator.of(context).pop();
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        final cubit = context.read<SignInCubit>();

        if (state.status.isAwaitingOtp) _showOtpDialog(cubit);
        if (state.status.isNewUser) _showNameDialog(cubit);

        if (state.status.isSuccess) {
          widget.onSignInSucessful(context);
        }

        if (state.status.hasError) {
          final error = _mapErrorToMessage(state.status);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignInCubit>();
        final textTheme = Theme.of(context).textTheme;

        return Scaffold(
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
                    controller: _mobileNumberController,
                  ),
                ),
                const SizedBox(height: 16),
                ExtendedElevatedButton(
                  label: 'Continue with Mobile',
                  icon: const Icon(Icons.phone),
                  onPressed: () => _submitPhone(cubit),
                ),
                const SizedBox(height: 16),
                ExtendedOutlineButton(
                  onPressed: cubit.continueWithGoogle,
                  label: 'Sign in with Google',
                  icon: Image.asset(
                    'assets/google_icon.png',
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
