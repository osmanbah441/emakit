import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for FilteringTextInputFormatter

class PhoneNumberInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? labelText;

  const PhoneNumberInputField({
    super.key,
    required this.controller,
    this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      autocorrect: false,

      decoration: InputDecoration(
        labelText: labelText ?? 'Phone Number',
        prefixIcon: Icon(Icons.phone),
      ),
      // Optional: Limit input to digits and '+' at the beginning for better UX
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[+0-9]*$')),
      ],
      validator: validator ?? _e164PhoneNumberValidator,
    );
  }

  // E.164 compliant phone number validation regex
  // This regex allows for an optional '+' at the beginning, followed by 1 to 15 digits.
  // It does not enforce specific country codes or formats beyond the E.164 length.
  static String? _e164PhoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty.';
    }

    // Regex for E.164:
    // ^\+           -> Must start with a literal '+'
    // \d{7,15}$     -> Must be followed by 7 to 15 digits (total length after '+')
    // This captures the common requirement for a "functional" phone number in E.164.
    final RegExp phoneRegex = RegExp(r'^\+\d{7,15}$');

    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number (e.g., +23278647879).';
    }

    return null; // Input is valid
  }
}
