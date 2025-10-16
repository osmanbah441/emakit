import 'package:flutter/gestures.dart';
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
class SignInView extends StatelessWidget {
  const SignInView({super.key, required this.onSignInSucessful});

  final VoidCallback onSignInSucessful;

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status == SignInSubmissionStatus.success) {
          onSignInSucessful();
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignInCubit>();
        final googleLoading =
            state.status == SignInSubmissionStatus.googleSignInLoading;
        final appleLoading =
            state.status == SignInSubmissionStatus.appleSignInLoading;

        final isLoading = googleLoading || appleLoading;
        final primaryColor = Theme.of(context).colorScheme.primary;

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Placeholder logo
                const Icon(Icons.storefront, size: 64, color: Colors.green),

                const SizedBox(height: 16),

                // Welcome message
                Text(
                  'Welcome to Salone Bazaar',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue shopping and selling with us.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 40),

                // Sign in buttons
                SignInWithGoogleButton(
                  onPressed: isLoading ? null : cubit.signInWithGoogle,
                  isLoading: googleLoading,
                ),
                const SizedBox(height: 16),
                SignInWithAppleButton(
                  onPressed: isLoading ? null : cubit.signInWithApple,
                  isLoading: appleLoading,
                ),

                const SizedBox(height: 32),

                // Terms & Conditions (RichText with links)
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    children: [
                      const TextSpan(text: 'By continuing, you agree to our '),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          color: isLoading ? Colors.grey : primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: isLoading
                            ? null
                            : (TapGestureRecognizer()
                                ..onTap = () {
                                  _showSnackBar(
                                    context,
                                    'Terms & Conditions tapped',
                                  );
                                }),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: isLoading ? Colors.grey : primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: isLoading
                            ? null
                            : (TapGestureRecognizer()
                                ..onTap = () {
                                  _showSnackBar(
                                    context,
                                    'Privacy Policy tapped',
                                  );
                                }),
                      ),
                      const TextSpan(text: '.'),
                    ],
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
