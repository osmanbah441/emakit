import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';

import 'complete_profile_cubit.dart';
import 'date_of_birth_field.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key, required this.onProfileComplete});

  final VoidCallback onProfileComplete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileCubit(),
      child: CompleteProfileView(onProfileComplete: onProfileComplete),
    );
  }
}

@visibleForTesting
class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key, required this.onProfileComplete});

  final VoidCallback onProfileComplete;

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _dobFieldKey = GlobalKey<DateOfBirthFieldState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  void _submitProfile(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final dateOfBirth = _dobFieldKey.currentState?.dateOfBirth;

      if (dateOfBirth == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete all fields.')),
        );
        return;
      }

      final currentUser = context
          .read<CompleteProfileCubit>()
          .state
          .currentUser;
      final isFullNameRequired = (currentUser?.displayName ?? '').isEmpty;

      context.read<CompleteProfileCubit>().submitProfile(
        formFullName: isFullNameRequired ? _fullNameController.text : null,

        dateOfBirth: dateOfBirth,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
            listener: (context, state) {
              if (state.status == CompleteProfileStatus.success) {
                widget.onProfileComplete();
              }
              if (state.status == CompleteProfileStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage ?? 'An unknown error occurred.',
                      ),
                    ),
                  );
              }
            },
            builder: (context, state) {
              final currentUser = state.currentUser;
              if (currentUser == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final isFullNameRequired =
                  (currentUser.displayName ?? '').isEmpty;

              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center content
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isFullNameRequired)
                      TextFormField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                        ),
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Required' : null,
                      ),

                    const SizedBox(height: 16),

                    DateOfBirthField(key: _dobFieldKey),
                    const SizedBox(height: 32),
                    if (state.status == CompleteProfileStatus.loading)
                      ExtendedElevatedButton.isLoadingProgress()
                    else
                      ExtendedElevatedButton(
                        label: 'Continue',
                        onPressed: () => _submitProfile(context),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
