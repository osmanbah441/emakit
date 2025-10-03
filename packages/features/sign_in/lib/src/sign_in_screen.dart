import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:user_repository/user_repository.dart';
import 'sign_in_cubit.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.onSignInSucessful});

  final VoidCallback onSignInSucessful;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(UserRepository.instance),
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
  void _showOtpDialog(BuildContext context, String phoneNumber) {
    final cubit = context.read<SignInCubit>();
    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: OtpVerification(
          mobileNumber: phoneNumber,
          onVerify: (smsCode) => cubit.verifyOtp(smsCode),
          onResend: () => cubit.sendOtp(phoneNumber),
        ),
      ),
    );
  }

  void _showUsernameDialog(BuildContext context) {
    final cubit = context.read<SignInCubit>();
    final usernameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Tell us you full name'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: usernameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'full name'),
              autovalidateMode: AutovalidateMode.onUnfocus,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    value.trim().length < 3) {
                  return 'full name must be at least 3 characters';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  cubit.setUsername(usernameController.text.trim());
                }
              },
              child: const Text('Save and Continue'),
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
        switch (state.status) {
          case SignInSubmissionStatus.codeSent:
            return _showOtpDialog(context, state.phoneNumber!);
          case SignInSubmissionStatus.success:
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            return widget.onSignInSucessful();
          case SignInSubmissionStatus.failure:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.error ?? 'Something went wrong')),
              );
            return;
          case SignInSubmissionStatus.usernameRequired:
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            return _showUsernameDialog(context);

          case SignInSubmissionStatus.initial:
          case SignInSubmissionStatus.loading:
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignInCubit>();
        final textTheme = Theme.of(context).textTheme;
        final isLoading = state.status == SignInSubmissionStatus.loading;

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhoneNumberInput(
                  onContinue: cubit.sendOtp,
                  lockedCountry: Country.sierraLeone,
                  isLoadingProgress: isLoading,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(child: Divider(endIndent: 16, indent: 32)),
                    Text('or', style: textTheme.titleMedium),
                    const Expanded(child: Divider(endIndent: 32, indent: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                ExtendedOutlineButton(
                  onPressed: isLoading ? null : cubit.signInWithGoogle,
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
