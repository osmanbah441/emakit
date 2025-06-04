import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemUiOverlayStyle

// --- Reusable Components (previous ones + new HorizontalOrderTracker) ---

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}

/// A simple row to display a label and its corresponding value.
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const InfoRow({
    Key? key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style:
                labelStyle ??
                TextStyle(fontSize: 15.0, color: Colors.grey[700]),
          ),
          Text(
            value,
            style:
                valueStyle ??
                const TextStyle(fontSize: 15.0, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

/// Displays a section with a title and a list of key-value information rows.
class KeyValueSection extends StatelessWidget {
  final String title;
  final Map<String, String> data;
  final String? highlightKey; // Optional key whose value should be highlighted
  final TextStyle? highlightValueStyle; // Style for the highlighted value

  const KeyValueSection({
    Key? key,
    required this.title,
    required this.data,
    this.highlightKey,
    this.highlightValueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        ...data.entries.map((entry) {
          final bool shouldHighlight =
              highlightKey != null && entry.key == highlightKey;
          return InfoRow(
            label: entry.key,
            value: entry.value,
            valueStyle: shouldHighlight ? highlightValueStyle : null,
          );
        }).toList(),
        const SizedBox(height: 16.0), // Padding after each section
      ],
    );
  }
}

/// Displays the shipping address for an order.
class OrderShippingAddressDisplay extends StatelessWidget {
  final String address;

  const OrderShippingAddressDisplay({Key? key, required this.address})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        address,
        style: TextStyle(fontSize: 15.0, color: Colors.grey[700], height: 1.4),
      ),
    );
  }
}

/// A tile for displaying an individual order item within the order details.
class OrderItemTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int quantity;

  const OrderItemTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Item Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.broken_image,
                      size: 30,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16.0),

          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Quantity: $quantity',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A prominent button with a light blue background.
/// Reused from previous examples (Cart/Checkout).
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

/// Data model for a single step in the order status timeline.
class OrderStatusStep {
  final String status;
  final String date;
  final bool isCompleted;
  final IconData?
  icon; // Optional icon for the step, e.g., Icons.local_shipping

  OrderStatusStep({
    required this.status,
    required this.date,
    this.isCompleted = false,
    this.icon,
  });
}

/// **NEW WIDGET:** A widget to display a horizontal order tracking timeline.
class HorizontalOrderTracker extends StatelessWidget {
  final List<OrderStatusStep> steps;

  const HorizontalOrderTracker({Key? key, required this.steps})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Tracking',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height:
                70, // Sufficient height for content (icon + 2 lines of text)
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(steps.length * 2 - 1, (index) {
                if (index.isEven) {
                  // This is an actual step (icon and text)
                  final stepIndex = index ~/ 2;
                  final step = steps[stepIndex];
                  return Column(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: step.isCompleted
                              ? Colors.blue.shade700
                              : Colors.white,
                          border: Border.all(
                            color: step.isCompleted
                                ? Colors.blue.shade700
                                : Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: step.isCompleted
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : (step.icon != null
                                    ? Icon(
                                        step.icon,
                                        size: 16,
                                        color: Colors.grey[700],
                                      )
                                    : Container()), // Empty container if no icon
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        step.status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              11.0, // Reduced font size for horizontal fit
                          fontWeight: FontWeight.w600,
                          color: step.isCompleted
                              ? Colors.black
                              : Colors.grey[700],
                        ),
                        maxLines: 1, // Ensure text fits
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        step.date,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.0, // Further reduced for horizontal fit
                          color: Colors.grey[600],
                        ),
                        maxLines: 1, // Ensure text fits
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                } else {
                  // This is a connecting line between steps
                  final previousStepIndex = (index - 1) ~/ 2;
                  final bool isLineCompleted =
                      steps[previousStepIndex].isCompleted;
                  return Expanded(
                    child: Container(
                      height: 2.0,
                      color: isLineCompleted
                          ? Colors.blue.shade700
                          : Colors.grey.shade300,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ), // Small margin for spacing
                    ),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// --- End of Reusable Components ---

// --- Start of the Order Details Screen Example ---

class OrderDetailsScreen extends StatelessWidget {
  // Dummy Data for Order Details
  final Map<String, String> _orderInfo = {
    'Order Number': '#123456789',
    'Order Date': 'October 26, 2024',
    'Total Amount': '\$125.00',
  };

  final Map<String, String> _customerDetails = {
    'Customer Name': 'Sophia Clark',
    'Contact Information': 'sophia.clark@email.com',
  };

  final String _shippingAddress = '123 Elm Street, Apt 4B, Anytown, CA 91234';
  final String _orderStatus = 'Processing'; // Current textual status

  final List<Map<String, dynamic>> _orderItems = [
    {
      'imageUrl': 'https://picsum.photos/id/240/200/200', // Handmade Soap
      'title': 'Handmade Soap',
      'quantity': 2,
    },
    {
      'imageUrl': 'https://picsum.photos/id/241/200/200', // Organic Lotion
      'title': 'Organic Lotion',
      'quantity': 1,
    },
  ];

  // Data for the Horizontal Order Tracker
  final List<OrderStatusStep> _trackingSteps = [
    OrderStatusStep(
      status: 'Order Placed',
      date: 'July 20, 2024',
      isCompleted: true, // Assuming this is completed
      icon: Icons.circle_outlined, // Placeholder for order placed
    ),
    OrderStatusStep(
      status: 'Shipped',
      date: 'July 21, 2024',
      isCompleted: true, // Assuming this is completed
      icon: Icons.local_shipping, // Truck icon
    ),
    OrderStatusStep(
      status: 'Out for Delivery',
      date: 'July 22, 2024',
      isCompleted: false, // Assuming this is the current status
      icon: Icons.inventory_2_outlined, // Box icon
    ),
    OrderStatusStep(
      status: 'Delivered',
      date: 'July 23, 2024',
      isCompleted: false, // Assuming this is not yet completed
      icon: Icons
          .check, // Checkmark icon (though check is often for completed state)
    ),
  ];

  OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print('Back button pressed');
          },
        ),
        title: const Text('Order Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Information Section using KeyValueSection
            KeyValueSection(
              title: 'Order Information',
              data: _orderInfo,
              highlightKey: 'Total Amount', // Highlight the total amount
              highlightValueStyle: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            // Customer Details Section using KeyValueSection
            KeyValueSection(title: 'Customer Details', data: _customerDetails),

            // Shipping Address Section
            SectionTitle(title: 'Shipping Address'),
            OrderShippingAddressDisplay(address: _shippingAddress),
            const SizedBox(height: 16.0), // Padding before next section
            // Order Tracking Section
            HorizontalOrderTracker(steps: _trackingSteps),
            const SizedBox(height: 16.0), // Padding before next section
            // Order Items Section
            SectionTitle(title: 'Order Items'),
            ..._orderItems.map((item) {
              return OrderItemTile(
                imageUrl: item['imageUrl'] as String,
                title: item['title'] as String,
                quantity: item['quantity'] as int,
              );
            }).toList(),
            const SizedBox(height: 16.0), // Padding before next section
            // Order Status Section (from previous design, can be redundant with tracker)
            // Keeping for now as per original request, but it's covered by tracker
            SectionTitle(title: 'Order Status'),
            InfoRow(
              label: 'Current Status',
              value: _orderStatus,
              valueStyle: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30.0), // Space before button
            CheckoutButton(
              buttonText: 'Mark as Shipped',
              onPressed: () {
                print(
                  'Mark as Shipped button pressed for Order ${_orderInfo['Order Number']}',
                );
                // Implement logic to update order status
              },
            ),
            const SizedBox(height: 20.0), // Padding at the bottom
          ],
        ),
      ),
    );
  }
}
