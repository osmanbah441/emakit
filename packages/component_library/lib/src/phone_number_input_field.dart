import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberInputField extends StatelessWidget {
  const PhoneNumberInputField({
    super.key,
    required this.controller,
    this.countryCode = '+232',
    this.validNetworkCodes = const [
      // Default Sierra Leone Network Codes
      '76', '77', '78', '79', '75', '74', '73',
      '30', '31', '33', '34', '88', '99', '90',
    ],
  });

  final TextEditingController controller;
  final String countryCode;
  final List<String> validNetworkCodes;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      style: textTheme.titleMedium?.copyWith(letterSpacing: 4),
      keyboardType: TextInputType.number,
      inputFormatters: [
        // Assuming an 8-digit number for Sierra Leone. This could be
        // parameterized in the future if needed.
        LengthLimitingTextInputFormatter(8),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: 'Enter your number',
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
          child: Text(
            countryCode, // Use the provided country code
            style: textTheme.titleMedium,
          ),
        ),
      ),
      validator: (value) {
        const errorText = 'please enter a valid number';

        if (value == null || value.isEmpty) return errorText;
        // A simple length check for a typical number format.
        if (value.length < 8) return errorText;
        // Use the provided list for network code validation.
        final networkCode = value.substring(0, 2);
        if (!validNetworkCodes.contains(networkCode)) return errorText;
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
