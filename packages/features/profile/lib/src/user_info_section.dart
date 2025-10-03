import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/src/profile_cubit.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  // ADD THIS DIALOG METHOD for phone number input
  void _showLinkPhoneNumberDialog(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    showAdaptiveDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: PhoneNumberInput(
              onContinue: (phoneNumber) {
                // Close this dialog and start linking
                Navigator.of(dialogContext).pop();
                cubit.linkPhoneNumber(phoneNumber);
              },
              lockedCountry: Country.sierraLeone,
            ),
          ),
        );
      },
    );
  }

  // ADD THIS DIALOG METHOD for OTP verification
  void _showOtpDialog(BuildContext context, String phoneNumber) {
    final cubit = context.read<ProfileCubit>();
    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: OtpVerification(
          mobileNumber: phoneNumber,
          onVerify: (smsCode) => cubit.verifyPhoneNumberLink(smsCode),
          onResend: () => cubit.linkPhoneNumber(phoneNumber),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // Listen for changes in the phone linking status
        final status = state.phoneLinkingStatus;
        if (status == PhoneLinkingStatus.codeSent) {
          _showOtpDialog(context, state.linkingPhoneNumber!);
        } else if (status == PhoneLinkingStatus.success) {
          // Close OTP dialog if open
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Phone number linked successfully!'),
                backgroundColor: Colors.green,
              ),
            );
        } else if (status == PhoneLinkingStatus.failure) {
          // Close OTP dialog if open
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.linkingError ?? 'An error occurred'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
        }
      },
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.user == null) {
          return const Center(child: Text('Could not load user profile.'));
        }

        final textTheme = Theme.of(context).textTheme;
        final user = state.user!;
        final isEmailSet = user.email != null && user.email!.isNotEmpty;
        final isPhoneNumberSet =
            user.phoneNumber != null && user.phoneNumber!.isNotEmpty;

        final cubit = context.read<ProfileCubit>();
        final isLinkingPhone =
            state.phoneLinkingStatus == PhoneLinkingStatus.loading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 16,
          children: [
            Row(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      user.displayName ?? '',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (isEmailSet)
                      Text(user.email!, style: textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    if (isPhoneNumberSet)
                      Text(user.phoneNumber!, style: textTheme.bodyMedium),
                  ],
                ),

                UserProfileImage(
                  photoURL: user.photoURL,
                  onEditProfilePictureTapped: () {
                    // pick image update
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Feature coming')));
                  },
                ),
              ],
            ),
            if (!isEmailSet)
              TextButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  width: 24,
                  height: 24,
                  'assets/images/google_icon.png',
                  package: 'component_library',
                ),
                label: Text('Link Google Account'),
              ),

            if (!isPhoneNumberSet)
              isLinkingPhone
                  ? const CenteredProgressIndicator()
                  : TextButton.icon(
                      onPressed: () => _showLinkPhoneNumberDialog(context),
                      icon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: const Text('Add Phone Number'),
                    ),
          ],
        );
      },
    );
  }
}
