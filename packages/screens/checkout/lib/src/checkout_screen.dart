import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemUiOverlayStyle

/// A customizable radio selection tile, used for shipping and payment methods.
class RadioSelectionTile extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const RadioSelectionTile({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: Colors.black, // Active radio button color
              materialTapTargetSize:
                  MaterialTapTargetSize.shrinkWrap, // Reduce extra padding
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays the selected shipping address and a button to change it.
class ShippingAddressDisplay extends StatelessWidget {
  final String recipientName;
  final String addressLine1;
  final String addressLine2; // e.g., "City, State, USA"
  final VoidCallback onChangeAddress;

  const ShippingAddressDisplay({
    Key? key,
    required this.recipientName,
    required this.addressLine1,
    required this.addressLine2,
    required this.onChangeAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipping Address',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 28,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipientName,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        addressLine1,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        addressLine2,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Align(
                  alignment: Alignment.topRight,
                  child: OutlinedButton(
                    onPressed: onChangeAddress,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Minimize extra tap area
                      minimumSize: Size.zero, // Use smallest size
                    ),
                    child: const Text(
                      'Change Address',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A prominent button for proceeding to checkout.
/// Reused from Stitch Design (1).png
class CheckoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CheckoutButton({
    Key? key,
    required this.onPressed,
    this.buttonText = 'Proceed to Checkout',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: SizedBox(
        width: double.infinity, // Make the button fill the width
        height: 56.0, // Standard button height
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD3E0F2), // Light blue background
            foregroundColor: Colors.black87, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
            ),
            elevation: 0, // No shadow
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

// --- End of Reusable Components ---

// --- Start of the Checkout Screen Example ---

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedShippingMethod = 'Pickup'; // Default selected method
  String _selectedPaymentMethod = 'Credit Card'; // Default selected method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shipping Method Section
            const SizedBox(height: 20.0), // Space after order summary
            const Text(
              'Shipping Method',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            RadioSelectionTile(
              title: 'Pickup',
              value: 'Pickup',
              groupValue: _selectedShippingMethod,
              onChanged: (value) {
                setState(() {
                  _selectedShippingMethod = value!;
                });
              },
            ),
            RadioSelectionTile(
              title: 'Delivery',
              value: 'Delivery',
              groupValue: _selectedShippingMethod,
              onChanged: (value) {
                setState(() {
                  _selectedShippingMethod = value!;
                });
              },
            ),

            // Shipping Address Section
            ShippingAddressDisplay(
              recipientName: 'Ethan Harper',
              addressLine1: '123 Maple Street',
              addressLine2: 'Anytown, USA',
              onChangeAddress: () {
                print('Change Address tapped');
                // Navigate to address selection screen
              },
            ),

            // Payment Method Section
            const SizedBox(height: 20.0), // Space after shipping address
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            RadioSelectionTile(
              title: 'Credit Card',
              value: 'Credit Card',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
            ),
            RadioSelectionTile(
              title: 'Cash on Delivery',
              value: 'Cash on Delivery',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
            ),
            RadioSelectionTile(
              title: 'Mobile Money',
              value: 'Mobile Money',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
            ),
            const SizedBox(height: 20.0), // Space before button
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
        ), // Adjust padding if you have a main bottom nav bar
        child: CheckoutButton(
          buttonText: 'Place Order',
          onPressed: () {
            print('Place Order tapped!');
            print('Selected Shipping: $_selectedShippingMethod');
            print('Selected Payment: $_selectedPaymentMethod');
            // Implement actual order placement logic
          },
        ),
      ),
    );
  }
}
