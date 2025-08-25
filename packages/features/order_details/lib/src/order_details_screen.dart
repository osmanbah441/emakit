import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

import 'order_item_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              OrderSummarySection(
                subtotal: '35.00',
                shippingCost: '5.00',
                taxes: '0.89',
                total: 'NLE.  43.89',
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '0 of 10 items completed',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(8),
                      semanticsLabel: 'Progress',
                      value: 0.5,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),

              ...[
                OrderItemCard(
                  imageUrls: const ['https://picsum.photos/id/101/200/200'],
                  storeName: 'Quick Ship Electronics',
                  productName: 'Wireless Bluetooth Headphones',
                  status: 'Processing',
                  quantity: 2,
                  totalCost: 89.50,
                ),
                OrderItemCard(
                  imageUrls: const [
                    'https://picsum.photos/id/1015/200/200',
                    'https://picsum.photos/id/1016/200/200',
                  ],
                  storeName: 'Furniture First',
                  productName: 'Ergonomic Office Chair',
                  status: 'Shipped',
                  quantity: 1,
                  totalCost: 299.99,
                ),
                OrderItemCard(
                  imageUrls: const ['https://picsum.photos/id/103/200/200'],
                  storeName: 'Home Essentials',
                  productName: 'Designer Coffee Mug',
                  status: 'Delivered',
                  quantity: 3,
                  totalCost: 45.00,
                ),
                SizedBox(height: 48),
                OrderInfo(
                  orderId: id,
                  paymentMethod: 'Cash on Delivery',
                  shippingAddress: '123 Main St, Anytown USA',
                  date: DateTime.now().toString(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class OrderInfo extends StatelessWidget {
  const OrderInfo({
    super.key,
    required this.orderId,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.date,
  });

  final String orderId;
  final String paymentMethod;
  final String shippingAddress;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeyValueRow(label: 'Order ID', value: orderId),
        KeyValueRow(label: 'Date', value: date),
        KeyValueRow(label: 'Payment Method', value: paymentMethod),
        KeyValueRow(label: 'Shipping Address', value: shippingAddress),
      ],
    );
  }
}
