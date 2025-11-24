import 'package:flutter/material.dart';

// --- 0. Variation Card Component (UPDATED Image & Text Alignment) ---
class VariationCard extends StatelessWidget {
  final String imageUrl;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const VariationCard({
    super.key,
    required this.imageUrl,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150, // Fixed width for horizontal scrolling item
        height: 200, // Adjusted height to fit image and label
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
            width: isSelected ? 2.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.blue.shade100.withOpacity(0.5),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to start
          children: [
            // Image Area - No padding, extends to rounded corners
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8.0),
              ), // Only top corners rounded
              child: Image.network(
                imageUrl,
                height: 140, // Height for the image
                width: double.infinity, // Image fills the width
                fit: BoxFit
                    .cover, // Use cover to fill the space, cropping if necessary
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 140, // Maintain height even on error
                  width: double.infinity,
                  child: Center(child: Icon(Icons.image, color: Colors.grey)),
                ),
              ),
            ),
            // Label Area - Aligned to start, with horizontal padding
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.blue.shade800 : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start, // Explicitly align text to start
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 1. Toggle Switch Component (Unchanged from previous revision) ---
class ToggleSwitch extends StatefulWidget {
  final List<String> options;
  final int initialSelectedIndex;
  final ValueChanged<int> onSelectionChanged;

  const ToggleSwitch({
    super.key,
    required this.options,
    this.initialSelectedIndex = 0,
    required this.onSelectionChanged,
  });

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = List.generate(
      widget.options.length,
      (index) => index == widget.initialSelectedIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth - 36) / widget.options.length;

    return ToggleButtons(
      isSelected: _isSelected,
      onPressed: (int index) {
        setState(() {
          for (
            int buttonIndex = 0;
            buttonIndex < _isSelected.length;
            buttonIndex++
          ) {
            _isSelected[buttonIndex] = (buttonIndex == index);
          }
        });
        widget.onSelectionChanged(index);
      },
      borderRadius: BorderRadius.circular(8.0),
      selectedBorderColor: Colors.blue,
      borderColor: Colors.grey.shade300,
      fillColor: Colors.blue.shade50,
      selectedColor: Colors.blue.shade800,
      color: Colors.grey.shade700,
      constraints: BoxConstraints.expand(width: buttonWidth, height: 40),
      children: widget.options
          .map(
            (option) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(option),
            ),
          )
          .toList(),
    );
  }
}

// --- 2. Primary Button Component (Unchanged from previous revision) ---
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade400,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// --- 3. Main Screen: AddVariationScreen (Minor adjustments for new VariationCard height) ---
class AddVariationScreen extends StatefulWidget {
  const AddVariationScreen({super.key});

  @override
  State<AddVariationScreen> createState() => _AddVariationScreenState();
}

class _AddVariationScreenState extends State<AddVariationScreen> {
  int _selectedToggleIndex = 0; // Starts on 'Choose Existing' to match image
  int? _selectedVariationIndex = 0; // Tracks which variation card is selected

  // Example list of possible attributes (used for dropdowns)
  final Map<String, List<String>> _availableAttributes = {
    'Size': ['XS', 'S', 'M', 'L', 'XL'],
    'Color': ['Red', 'Blue', 'Green', 'Black'],
  };

  // Example list of existing variations (used for the horizontal cards)
  final List<Map<String, String>> _existingVariations = [
    {
      'image': 'https://picsum.photos/seed/redshirt/300/300',
      'label': 'Red, Medium',
      'attributes': 'Color: Red, Size: M', // Attributes for dropdowns
    },
    {
      'image': 'https://picsum.photos/seed/blueshirt/300/300',
      'label': 'Blue, Medium',
      'attributes': 'Color: Blue, Size: M',
    },
    {
      'image': 'https://picsum.photos/seed/greenshirt/300/300',
      'label': 'Green, Small',
      'attributes': 'Color: Green, Size: S',
    },
    {
      'image': 'https://picsum.photos/seed/blackshirt/300/300',
      'label': 'Black, Large',
      'attributes': 'Color: Black, Size: L',
    },
  ];

  Map<String, String?> _selectedAttributes = {};

  final TextEditingController _priceController = TextEditingController(
    text: '19.99',
  );
  final TextEditingController _stockController = TextEditingController(
    text: '10',
  );

  @override
  void initState() {
    super.initState();
    // Initialize selected attributes to match the default selected card (index 0)
    _updateAttributesFromVariation(0);
  }

  @override
  void dispose() {
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _updateAttributesFromVariation(int index) {
    final variation = _existingVariations[index];
    _selectedAttributes.clear();

    final attributeList = variation['attributes']!.split(', ');
    for (var attr in attributeList) {
      final parts = attr.split(': ');
      if (parts.length == 2) {
        _selectedAttributes[parts[0]] = parts[1];
      }
    }
  }

  void _handleToggleSelection(int index) {
    setState(() {
      _selectedToggleIndex = index;
    });
    print("Switched to ${index == 0 ? 'Choose Existing' : 'Create New'}");
  }

  void _handleAttributeChange(String attributeName, String? newValue) {
    setState(() {
      _selectedAttributes[attributeName] = newValue;
      print('Selected $attributeName: $newValue');
    });
  }

  void _handleVariationCardTap(int index) {
    setState(() {
      _selectedVariationIndex = index;
      _updateAttributesFromVariation(
        index,
      ); // Update dropdowns to reflect selected card
    });
  }

  void _handleAddVariation() {
    print('Add Variation button pressed!');
  }

  @override
  Widget build(BuildContext context) {
    final bool isChooseExisting = _selectedToggleIndex == 0;

    // --- Content for Attribute Dropdowns (placed directly) ---
    final Widget attributeDropdowns = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: _availableAttributes.entries.map((entry) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: entry.key == _availableAttributes.keys.last ? 0 : 8.0,
                bottom: 24.0,
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: entry
                      .key, // Label is now just the attribute name (e.g., 'Size')
                  hintText: 'Select ${entry.key}',
                  fillColor: Colors.white,
                  filled: true,
                ),
                isExpanded: true,
                value: _selectedAttributes[entry.key],
                items: entry.value.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) =>
                    _handleAttributeChange(entry.key, newValue),
              ),
            ),
          );
        }).toList(),
      ),
    );

    // --- Content for Offer Details Section Card ---
    final Widget offerDetailsCard = Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Offer Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price*',
                  hintText: 'e.g. \$19.99',
                ),
              ),
            ),
            TextFormField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stock Quantity*',
                hintText: 'e.g. 10',
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Variation & Offers',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => print('Save button pressed!'),
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Toggle Buttons Container (to provide horizontal padding) ---
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
                bottom: 24.0,
              ),
              child: Center(
                child: ToggleSwitch(
                  options: const ['Choose Existing', 'Create New'],
                  initialSelectedIndex: _selectedToggleIndex,
                  onSelectionChanged: _handleToggleSelection,
                ),
              ),
            ),

            // --- Main Content Area ---
            if (isChooseExisting) ...[
              // 1. Attribute Dropdowns
              attributeDropdowns,

              // 2. Horizontal Variation Cards (Scrollable)
              SizedBox(
                height: 200, // Matches the height of VariationCard
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: _existingVariations.length,
                  itemBuilder: (context, index) {
                    final variation = _existingVariations[index];
                    return Stack(
                      children: [
                        VariationCard(
                          imageUrl: variation['image']!,
                          label: variation['label']!,
                          isSelected: _selectedVariationIndex == index,
                          onTap: () => _handleVariationCardTap(index),
                        ),
                        // Checkmark icon position on the card itself, not inside
                        if (_selectedVariationIndex == index)
                          Positioned(
                            top: 12,
                            right:
                                20, // Adjusted to be inside the card and visible
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors
                                    .blue, // Blue background for checkmark
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // 3. Offer Details Card
              offerDetailsCard,
              const SizedBox(height: 32),
            ] else // isCreateNew
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text(
                    'Coming up next...',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PrimaryButton(
          text: 'Add Variation',
          onPressed: _handleAddVariation,
        ),
      ),
    );
  }
}

// --- Main Application Runner ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Variation & Offers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
      ),
      home: const AddVariationScreen(),
    );
  }
}
