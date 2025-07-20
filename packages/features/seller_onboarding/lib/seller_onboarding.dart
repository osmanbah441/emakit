import 'package:flutter/material.dart';
import 'package:seller_onboarding/src/consumer_protection_content.dart';
import 'package:seller_onboarding/src/policy_dialog.dart';
import 'package:seller_onboarding/src/privacy_policy_content.dart';
import 'package:seller_onboarding/src/seller_terms_content.dart';

class SellerApplicationScreen extends StatefulWidget {
  const SellerApplicationScreen({super.key});

  @override
  State<SellerApplicationScreen> createState() =>
      _SellerApplicationScreenState();
}

class _SellerApplicationScreenState extends State<SellerApplicationScreen> {
  bool _sellerTermsChecked = false;
  bool _privacyPolicyChecked = false;
  bool _consumerProtectionChecked = false;

  bool get _isGetStartedEnabled =>
      _sellerTermsChecked &&
      _privacyPolicyChecked &&
      _consumerProtectionChecked;

  void _showPolicyDialog(BuildContext context, String title, String content) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return PolicyDialog(title: title, content: content);
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Image.network(
                'https://picsum.photos/400/250?random=1', // Random image from Picsum
                fit: BoxFit.cover, // Cover the area
                loadingBuilder:
                    (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.error_outline), // Fallback icon for error
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to our seller community',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Join a vibrant marketplace of creators and entrepreneurs. Start selling your unique products today and reach a global audience.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),
                    _buildPolicyCheckbox(
                      text: 'Seller Terms and Conditions',
                      isChecked: _sellerTermsChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _sellerTermsChecked = value ?? false;
                        });
                      },
                      onTapText: () => _showPolicyDialog(
                        context,
                        'Seller Terms and Conditions',
                        sellerTermsContent,
                      ),
                    ),
                    _buildPolicyCheckbox(
                      text: 'Privacy Policy',
                      isChecked: _privacyPolicyChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _privacyPolicyChecked = value ?? false;
                        });
                      },
                      onTapText: () => _showPolicyDialog(
                        context,
                        'Privacy Policy',
                        privacyPolicyContent,
                      ),
                    ),
                    _buildPolicyCheckbox(
                      text: 'Consumer Protection Policy / Buyer Terms',
                      isChecked: _consumerProtectionChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _consumerProtectionChecked = value ?? false;
                        });
                      },
                      onTapText: () => _showPolicyDialog(
                        context,
                        'Consumer Protection Policy / Buyer Terms',
                        consumerProtectionContent,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isGetStartedEnabled
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SellerOnboardingStep1Screen(),
                                  ),
                                );
                              }
                            : null,
                        child: const Text('Get Started'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyCheckbox({
    required String text,
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
    required VoidCallback onTapText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(value: isChecked, onChanged: onChanged),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: onTapText,
              child: Text(
                text,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Seller Onboarding - Step 1 Screen Widget ---
class SellerOnboardingStep1Screen extends StatefulWidget {
  const SellerOnboardingStep1Screen({super.key});

  @override
  State<SellerOnboardingStep1Screen> createState() =>
      _SellerOnboardingStep1ScreenState();
}

class _SellerOnboardingStep1ScreenState
    extends State<SellerOnboardingStep1Screen> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessPhoneController =
      TextEditingController();
  final TextEditingController _registrationNumberController =
      TextEditingController();

  final List<String> _goodsCategories = [
    'Handmade Crafts',
    'Food & Beverage',
    'Clothing & Accessories',
    'Art & Collectibles',
    'Other',
  ];
  final List<String> _selectedCategories = [];

  bool get _isNextButtonEnabled {
    return _businessNameController.text.isNotEmpty &&
        _businessPhoneController.text.isNotEmpty &&
        _selectedCategories.isNotEmpty;
  }

  void _updateButtonState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _businessNameController.addListener(_updateButtonState);
    _businessPhoneController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _businessNameController.removeListener(_updateButtonState);
    _businessPhoneController.removeListener(_updateButtonState);
    _businessNameController.dispose();
    _businessPhoneController.dispose();
    _registrationNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Seller Onboarding'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator Text
              const Text('Step 1 of 4'),
              const SizedBox(height: 8),
              // Linear Progress Bar
              LinearProgressIndicator(
                value: 0.25,
                backgroundColor: Theme.of(context).disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'Business Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),

              // Business Name Field
              const Text('Business Name'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _businessNameController,
                hintText: 'Enter business name',
              ),
              const SizedBox(height: 24),

              // Business Phone Number Field
              const Text('Business Phone Number'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _businessPhoneController,
                hintText: 'Enter phone number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              // Type of Goods/Services Sold
              const Text('Type of Goods/Services Sold'),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _goodsCategories.map((category) {
                  final isSelected = _selectedCategories.contains(category);
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedCategories.add(category);
                        } else {
                          _selectedCategories.remove(category);
                        }
                        _updateButtonState();
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Business Registration Number (Optional) Field
              const Text('Business Registration Number (Optional)'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _registrationNumberController,
                hintText: 'Enter registration number',
                isOptional: true,
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isNextButtonEnabled
                      ? () {
                          print(
                            'Business Name: ${_businessNameController.text}',
                          );
                          print(
                            'Business Phone: ${_businessPhoneController.text}',
                          );
                          print('Selected Categories: $_selectedCategories');
                          print(
                            'Registration Number: ${_registrationNumberController.text}',
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Step 1 data collected! Proceeding...',
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool isOptional = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        filled: true,
      ),
    );
  }
}

// --- Main Application Entry Point ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mooemart',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.green),
      home: const SellerApplicationScreen(),
    );
  }
}
