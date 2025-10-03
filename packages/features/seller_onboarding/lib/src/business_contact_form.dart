import 'package:component_library/component_library.dart';
import 'package:dataconnect/dataconnect.dart';
import 'package:flutter/material.dart';

class BusinessContactForm extends StatefulWidget {
  const BusinessContactForm({super.key});

  @override
  State<BusinessContactForm> createState() => _BusinessContactFormState();
}

class _BusinessContactFormState extends State<BusinessContactForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _businessNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _showDialog() => showDialog(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      return AlertDialog(
        title: const Text('Application Submitted'),
        content: const Text(
          'Thank you for applying to become a seller on Salone Bazaar!\n\n'
          'Our team will contact you shortly to verify your information '
          'and help you get started on the platform.',
        ),
        actions: [
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );

  void _showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitForm() async {
    // if (!_formKey.currentState!.validate()) return;

    // setState(() {
    //   _isLoading = true;
    // });

    // try {
    //   await DataConnect.instance.userRepository.applyToBecomeSeller(
    //     businessName: _businessNameController.text,
    //     phoneNumber: _phoneNumberController.text,
    //   );

    //   setState(() {
    //     _isLoading = false;
    //   });

    //   if (context.mounted) {
    //     _showDialog();
    //     _formKey.currentState!.reset();
    //     _businessNameController.clear();
    //     _phoneNumberController.clear();
    //   }
    // } catch (e) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   if (mounted) {
    //     _showErrorDialog(
    //       context: context,
    //       title: 'Error',
    //       message:
    //           'Failed to apply to become a seller. Please try again later.',
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _businessNameController,
            decoration: const InputDecoration(
              labelText: 'Business Name',
              prefixIcon: Icon(Icons.business_center_outlined),
            ),
            validator: (value) {
              if (value == null || value.length < 3) {
                return 'Please enter your valid business name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // PhoneNumberInputField(
          //   controller: _phoneNumberController,
          //   // labelText: 'Business Phone Number',
          // ),
          const SizedBox(height: 16),
          _isLoading
              ? ExtendedElevatedButton.isLoadingProgress(label: 'Loading...')
              : ExtendedElevatedButton(
                  label: 'Apply to become a seller',
                  onPressed: _isLoading ? null : _submitForm,
                ),
        ],
      ),
    );
  }
}
