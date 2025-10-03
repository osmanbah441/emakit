import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _UniversalPhoneNumberFormatter extends TextInputFormatter {
  final int networkCodeLength;

  const _UniversalPhoneNumberFormatter({required this.networkCodeLength});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.isEmpty) {
      return const TextEditingValue();
    }

    var buffer = StringBuffer();

    if (networkCodeLength > 0 && digitsOnly.length > networkCodeLength) {
      buffer.write(digitsOnly.substring(0, networkCodeLength));
      buffer.write(' ');

      final numberPart = digitsOnly.substring(networkCodeLength);
      for (var i = 0; i < numberPart.length; i += 3) {
        final end = (i + 3 < numberPart.length) ? i + 3 : numberPart.length;
        buffer.write(numberPart.substring(i, end));
        if (end < numberPart.length) {
          buffer.write(' ');
        }
      }
    } else {
      buffer.write(digitsOnly);
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

enum Country {
  sierraLeone(
    name: 'Sierra Leone',
    flag: '🇸🇱',
    code: '+232',
    maxLength: 8,
    networkCodeLength: 2,
    networkCodes: [
      '76',
      '77',
      '78',
      '79',
      '75',
      '74',
      '73',
      '30',
      '31',
      '33',
      '34',
      '88',
      '99',
      '90',
    ],
  ),
  nigeria(
    name: 'Nigeria',
    flag: '🇳🇬',
    code: '+234',
    maxLength: 10,
    networkCodeLength: 3,
    networkCodes: ['803', '805', '806', '807', '703', '705'],
  ),
  ghana(
    name: 'Ghana',
    flag: '🇬🇭',
    code: '+233',
    maxLength: 9,
    networkCodeLength: 2,
    networkCodes: ['24', '54', '55', '20', '50'],
  ),
  unitedStates(
    name: 'United States',
    flag: '🇺🇸',
    code: '+1',
    maxLength: 10,
    networkCodeLength: 3,
  ),
  unitedKingdom(
    name: 'United Kingdom',
    flag: '🇬🇧',
    code: '+44',
    maxLength: 10,
    networkCodeLength: 4,
  ),
  canada(
    name: 'Canada',
    flag: '🇨🇦',
    code: '+1',
    maxLength: 10,
    networkCodeLength: 3,
  );

  const Country({
    required this.name,
    required this.flag,
    required this.code,
    required this.maxLength,
    this.networkCodeLength = 0,
    this.networkCodes,
  });

  final String name;
  final String flag;
  final String code;
  final int maxLength;
  final int networkCodeLength;
  final List<String>? networkCodes;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    final rawPhoneNumber = value.replaceAll(RegExp(r'\D'), '');
    if (rawPhoneNumber.length != maxLength) {
      return 'Please enter a valid phone number';
    }
    if (networkCodes != null) {
      final networkCode = rawPhoneNumber.substring(0, networkCodeLength);
      if (!networkCodes!.contains(networkCode)) {
        return 'Please enter a valid phone number';
      }
    }
    return null;
  }
}

class PhoneNumberInput extends StatefulWidget {
  final Function(String fullPhoneNumber)? onContinue;
  final Country? lockedCountry;
  final String title;
  final bool isLoadingProgress;

  const PhoneNumberInput({
    super.key,
    this.onContinue,
    this.lockedCountry,
    this.isLoadingProgress = false,
    this.title = 'Login to Salone Bazaar',
  });

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    // later you could you localization to get the user country
    _selectedCountry = widget.lockedCountry ?? Country.sierraLeone;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    if (_formKey.currentState!.validate()) {
      final rawPhoneNumber = _phoneController.text.replaceAll(
        RegExp(r'\D'),
        '',
      );
      final fullPhoneNumber = '${_selectedCountry.code}$rawPhoneNumber';
      widget.onContinue?.call(fullPhoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "We'll send a verification code to this number.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            enabled: widget.isLoadingProgress ? false : true,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(_selectedCountry.maxLength),
              _UniversalPhoneNumberFormatter(
                networkCodeLength: _selectedCountry.networkCodeLength,
              ),
            ],
            decoration: InputDecoration(
              labelText: 'Phone number',
              prefix: _CountryCodePicker(
                initialCountry: _selectedCountry,
                isLocked: widget.lockedCountry != null,
                onCountryChanged: (country) {
                  setState(() {
                    _selectedCountry = country;
                    _phoneController.clear();
                    _formKey.currentState?.validate();
                  });
                },
              ),
            ),
            validator: _selectedCountry.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 24),
          widget.isLoadingProgress
              ? ExtendedElevatedButton.isLoadingProgress()
              : ExtendedElevatedButton(
                  label: 'Continue with phone number',
                  icon: Icon(Icons.phone_outlined),
                  onPressed: _onContinuePressed,
                ),
        ],
      ),
    );
  }
}

class _CountryCodePicker extends StatelessWidget {
  final Country initialCountry;
  final ValueChanged<Country> onCountryChanged;
  final bool isLocked;

  const _CountryCodePicker({
    required this.initialCountry,
    required this.onCountryChanged,
    this.isLocked = false,
  });

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: ListView.builder(
            itemCount: Country.values.length,
            itemBuilder: (context, index) {
              final country = Country.values[index];
              return ListTile(
                onTap: () {
                  onCountryChanged(country);
                  Navigator.of(context).pop();
                },
                leading: Text(
                  country.flag,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(country.name),
                trailing: Text(country.code),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLocked ? null : () => _showCountryPicker(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(initialCountry.flag, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(initialCountry.code),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
