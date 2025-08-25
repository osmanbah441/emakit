import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  final List<String> imageUrls;
  final String storeName;
  final String productName;
  final String status;
  final int quantity;
  final double totalCost;

  const OrderItemCard({
    super.key,
    required this.imageUrls,
    required this.storeName,
    required this.productName,
    required this.status,
    required this.quantity,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
      case 'Delivered':
        statusColor = Colors.green;
        break;
      case 'Shipped':
        statusColor = Colors.blue;
        break;
      case 'Processing':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store Name and Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.store, color: Colors.indigo, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      storeName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
                // Actions Menu
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$result action selected')),
                    );
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Confirm',
                          child: Text('Confirm Order'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'contact',
                          child: Text('Contact Seller'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'cancel',
                          child: Text('Cancel Order'),
                        ),
                      ],
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            const Divider(height: 24),
            // Product Images and Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Carousel
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // Product Name, Quantity, and Cost
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Qty: $quantity',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${totalCost.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Status Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Status: $status',
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
