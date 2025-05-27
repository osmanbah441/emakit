import 'package:component_library/component_library.dart';
import 'package:component_library/src/primary_action_button.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.onCheckoutTap});

  final Function(BuildContext context) onCheckoutTap;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Example primitive data for cart items
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'imageUrl':
          'https://picsum.photos/id/1012/200/200', // Example Picsum image
      'title': 'Cozy Knit Sweater',
      'quantity': 1,
    },
    {
      'id': '2',
      'imageUrl': 'https://picsum.photos/id/1025/200/200',
      'title': 'Classic Blue Jeans',
      'quantity': 2,
    },
    {
      'id': '3',
      'imageUrl': 'https://picsum.photos/id/1084/200/200',
      'title': 'Leather Ankle Boots',
      'quantity': 1,
    },
  ];

  // Placeholder for calculating totals
  double _calculateSubtotal() {
    // This is a simplified calculation, you'd get actual prices
    double pricePerItem = 80.0; // Placeholder price
    double subtotal = 0.0;
    for (var item in _cartItems) {
      subtotal += (item['quantity'] as int) * pricePerItem;
    }
    return subtotal;
  }

  // Handle quantity changes for demonstration
  void _updateQuantity(String itemId, int change) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item['id'] == itemId);
      if (index != -1) {
        int newQuantity = _cartItems[index]['quantity'] + change;
        if (newQuantity > 0) {
          _cartItems[index]['quantity'] = newQuantity;
        } else {
          // Optionally remove item if quantity becomes 0
          _cartItems.removeAt(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = _calculateSubtotal();
    double shipping = 0.0; // Assuming free shipping for simplicity
    double taxesRate = 0.06; // 6% tax
    double taxes = subtotal * taxesRate;
    double total = subtotal + shipping + taxes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ..._cartItems.map((item) {
            return CartItemRow(
              imageUrl: item['imageUrl'] as String,
              title: item['title'] as String,
              quantityText: 'Quantity: ${item['quantity']}',
              currentQuantity: item['quantity'] as int,
              onDecrement: () => _updateQuantity(item['id'] as String, -1),
              onIncrement: () => _updateQuantity(item['id'] as String, 1),
            );
          }),
          const SizedBox(height: 20.0),

          // Order Summary Section
          OrderSummarySection(
            subtotal: '\$${subtotal.toStringAsFixed(2)}',
            shippingCost: shipping == 0.0
                ? 'Free'
                : '\$${shipping.toStringAsFixed(2)}',
            taxes: '\$${taxes.toStringAsFixed(2)}',
            total: '\$${total.toStringAsFixed(2)}',
          ),
          PrimaryActionButton(
            onPressed: () => widget.onCheckoutTap(context),
            label: 'Proceed to Checkout',
          ),
        ],
      ),
    );
  }
}
