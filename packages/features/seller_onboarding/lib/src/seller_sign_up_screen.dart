import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class SellerSignUpScreen extends StatefulWidget {
  const SellerSignUpScreen({super.key});
  @override
  State<SellerSignUpScreen> createState() => _SellerSignUpScreenState();
}

class _SellerSignUpScreenState extends State<SellerSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  DateTime? _dob;
  String? _district, _sex, _docType;

  @override
  void dispose() {
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _dob ?? DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dob = picked;
        _dobController.text =
            "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  bool _isAdult(DateTime date) {
    final today = DateTime.now();
    final age = today.year - date.year;
    final hasHadBirthday =
        (today.month > date.month) ||
        (today.month == date.month && today.day >= date.day);
    return (hasHadBirthday ? age : age - 1) >= 18;
  }

  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return _snack('Please correct the errors in the form.');
    }
    _snack('Form Submitted Successfully!');
    debugPrint(
      'DOB: $_dob, Phone: ${_phoneController.text}, District: $_district, Sex: $_sex, Doc: $_docType',
    );
  }

  final _docTypeOptions = const ['Passport', 'National ID'];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: Navigator.of(context).pop,
      ),
      title: const Text('Seller Sign Up'),
      centerTitle: true,
    ),
    body: Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoForm(
              dobController: _dobController,
              onPickDate: _pickDate,
              phoneCtrl: _phoneController,
              district: _district,
              onDistrict: (v) => setState(() => _district = v),
              sex: _sex,
              onSex: (v) => setState(() => _sex = v),
              validateDOB: (value) {
                if (value == null || value.isEmpty) {
                  return 'Date of Birth is required.';
                }
                if (_dob == null || !_isAdult(_dob!)) {
                  return 'You must be at least 18 years old.';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Text(
              'Identification Documents',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Identification Document Type',
                hintText: 'Select Document Type',
              ),
              onChanged: (v) => setState(() => _docType = v),
              validator: (v) =>
                  v == null ? 'Please select a document type.' : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              items: _docTypeOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
            ),
            const SizedBox(height: 30),
            ImagePickerComponent(onImageSelected: () {}),
            const SizedBox(height: 30),
            ImagePickerComponent(onImageSelected: () {}),

            const SizedBox(height: 40),
            PrimaryActionButton(label: 'Become a seller', onPressed: _submit),
          ],
        ),
      ),
    ),
  );
}

class _InfoForm extends StatelessWidget {
  const _InfoForm({
    required this.dobController,
    required this.onPickDate,
    required this.phoneCtrl,
    required this.district,
    required this.onDistrict,
    required this.sex,
    required this.onSex,
    required this.validateDOB,
  });

  final TextEditingController dobController, phoneCtrl;
  final VoidCallback onPickDate;
  final String? district, sex;
  final ValueChanged<String?> onDistrict, onSex;
  final String? Function(String?) validateDOB;

  final _sexOptions = const ['Male', 'Female', 'Other'];
  final _districtOptions = const [
    'District A',
    'District B',
    'District C',
    'District D',
  ];

  String? _validatePhone(String? v) {
    if (v == null || v.isEmpty) return 'Phone number is required.';
    return RegExp(r'^\+?[0-9\s\-\(\)]{7,}$').hasMatch(v)
        ? null
        : 'Enter a valid phone number.';
  }

  String? _validateSex(String? v) => v == null ? 'Please select a sex.' : null;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Please provide your personal information.',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 15),
      TextFormField(
        controller: dobController,
        readOnly: true,
        onTap: onPickDate,
        decoration: const InputDecoration(
          labelText: 'Date of Birth',
          suffixIcon: Icon(Icons.calendar_today_outlined),
        ),
        validator: validateDOB,
      ),
      const SizedBox(height: 20),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'District',
          hintText: 'Select District',
        ),
        onChanged: onDistrict,
        validator: (v) => v == null ? 'Please select a district.' : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        items: _districtOptions
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
      ),
      const SizedBox(height: 20),
      TextFormField(
        controller: phoneCtrl,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          hintText: 'e.g., +123 456 7890',
        ),
        validator: _validatePhone,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
      const SizedBox(height: 20),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: 'Sex', hintText: 'Select Sex'),
        onChanged: onSex,
        validator: _validateSex,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        items: _sexOptions
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
      ),
    ],
  );
}
