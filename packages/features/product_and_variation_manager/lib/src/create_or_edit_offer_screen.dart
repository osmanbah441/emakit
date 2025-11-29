import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:product_and_variation_manager/src/components/active_offer_toggle_component.dart';
import 'package:product_and_variation_manager/src/components/add_variant_button_component.dart';

class CreateOrEditOfferScreen extends StatefulWidget {
  const CreateOrEditOfferScreen({super.key});

  @override
  State<CreateOrEditOfferScreen> createState() =>
      _CreateOrEditOfferScreenState();
}

class _CreateOrEditOfferScreenState extends State<CreateOrEditOfferScreen> {
  // Toggle this to switch between Edit and Add modes (for demonstration)
  bool isEditing = true;
  bool hasChanges = false; // Tracks if form data has been modified

  // --- Initial Data (Simulated fetched data) ---
  final String initialPrice = '29.99';
  final String initialStock = '150';
  final bool initialIsActive = true;

  // --- Current State Controllers ---
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late bool _currentIsActive;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current/initial values based on mode
    _priceController = TextEditingController(
      text: isEditing ? initialPrice : '',
    );
    _stockController = TextEditingController(
      text: isEditing ? initialStock : '',
    );
    _currentIsActive = initialIsActive;

    // Listeners for text field changes
    _priceController.addListener(_checkForChanges);
    _stockController.addListener(_checkForChanges);
  }

  @override
  void dispose() {
    _priceController.removeListener(_checkForChanges);
    _stockController.removeListener(_checkForChanges);
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  // --- Change Detection Logic ---
  void _checkForChanges() {
    // Only check for changes if we are in Edit Mode
    bool priceChanged = _priceController.text != initialPrice;
    bool stockChanged = _stockController.text != initialStock;
    bool activeChanged = _currentIsActive != initialIsActive;

    bool changes = isEditing && (priceChanged || stockChanged || activeChanged);

    if (changes != hasChanges) {
      setState(() {
        hasChanges = changes;
      });
    }
  }

  void _updateActiveStatus(bool value) {
    setState(() {
      _currentIsActive = value;
    });
    // Trigger change check immediately after state update
    _checkForChanges();
  }

  // Handle switching mode (for demo purposes)
  void _toggleEditMode(bool value) {
    setState(() {
      isEditing = value;
      // Reset controllers when switching to Add mode
      if (!isEditing) {
        _priceController.text = '';
        _stockController.text = '';
        _currentIsActive = true; // Default to active for new offer
      } else {
        // Re-populate on Edit mode switch
        _priceController.text = initialPrice;
        _stockController.text = initialStock;
        _currentIsActive = initialIsActive;
      }
      hasChanges = false; // No changes right after mode switch
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final productHeader = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BrandName Inc.', style: textTheme.labelMedium),
        SizedBox(height: 4),
        Text('Summer Breeze Tee', style: textTheme.titleMedium),
        SizedBox(height: 4),
        Text('Size: M, Color: Blue', style: textTheme.labelLarge),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text(isEditing ? 'Edit Offer' : 'Add Offer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productHeader,
                  const SizedBox(height: 20),

                  const ProductImageComponent(),
                  const SizedBox(height: 24),
                  PriceStockRowComponent(
                    priceController: _priceController,
                    stockController: _stockController,
                  ),
                  const SizedBox(height: 24),
                  ActiveOfferToggleComponent(
                    isActive: _currentIsActive,
                    onChanged: _updateActiveStatus,
                  ),
                  const SizedBox(height: 24),
                  AddVariantButtonComponent(onTap: () {}),
                  const SizedBox(height: 24),
                  const ProductSpecificationsComponent(),
                  const SizedBox(height: 48), // Spacing for bottom button
                ],
              ),
            ),
          ),
          PrimaryActionButton(label: 'lald'),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// COMPONENTS
// ---------------------------------------------------------------------------

class ProductImageComponent extends StatelessWidget {
  const ProductImageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          // Using a placeholder image that resembles a t-shirt
          image: NetworkImage(
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PriceStockRowComponent extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController stockController;

  const PriceStockRowComponent({
    super.key,
    required this.priceController,
    required this.stockController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: priceController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: 'NLe ',
                  labelText: 'Price',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Stock',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: stockController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: '0'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductSpecificationsComponent extends StatelessWidget {
  const ProductSpecificationsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Product Specifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        _SpecRow(label: 'Material', value: '100% Organic Cotton'),
        SizedBox(height: 8),
        _SpecRow(label: 'Origin', value: 'Made in USA'),
        SizedBox(height: 8),
        _SpecRow(label: 'Care', value: 'Machine wash cold, tumble dry low'),
      ],
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;

  const _SpecRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, height: 1.4),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
