import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

enum OrderStatus { pending, inProcess, delivered, accepted, rejected }

class OrderListItem extends StatefulWidget {
  const OrderListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.onTap,
    required this.orderStatus,
    this.onConfirmTapped,
    this.onCancelTapped,
    this.onChatTapped,
    this.onDisputeTapped,
  });

  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  final VoidCallback onTap;
  final OrderStatus orderStatus;
  final VoidCallback? onConfirmTapped;
  final VoidCallback? onCancelTapped;
  final VoidCallback? onChatTapped;
  final void Function(bool isSellerAtFault)? onDisputeTapped;

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  @override
  Widget build(BuildContext context) {
    return ItemListCard(
      imageUrl: widget.imageUrl,
      title: widget.title,
      price: widget.price,
      subtitle: Text('Quantity: ${widget.quantity}'),
      onTap: widget.onTap,
      action: _buildActions(context),
    );
  }

  Widget _buildActions(BuildContext context) {
    const iconSize = 32.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatusIndicator(),
        const Spacer(),
        // Conditionally show buttons based on order status
        switch (widget.orderStatus) {
          OrderStatus.delivered => Row(
            children: [
              IconButton(
                onPressed: () async {
                  final confirmed = await _showConfirmDialog(
                    context,
                    title: 'Accept Order',
                    content:
                        'By accepting this order, you confirm that you have received '
                        'the item and it is in good condition. This action cannot be undone.',
                    confirmText: 'Accept',
                  );
                  if (confirmed == true) {
                    widget.onConfirmTapped?.call();
                  }
                },
                tooltip: 'Accept order',
                color: Colors.green,
                iconSize: iconSize,
                icon: const Icon(Icons.check_circle_outline),
              ),
              IconButton(
                onPressed: () async {
                  await _showDisputeDialog(context);
                },
                tooltip: 'Reject order',
                color: Colors.red,
                iconSize: iconSize,
                icon: const Icon(Icons.cancel_outlined),
              ),
            ],
          ),
          OrderStatus.pending || OrderStatus.inProcess => Row(
            children: [
              IconButton(
                onPressed: () async {
                  final confirmed = await _showConfirmDialog(
                    context,
                    title: 'Start Chat with Vendor',
                    content:
                        'Chats are public and can be read by platform administrators. '
                        'This helps us ensure accountability and resolve disputes. '
                        'You can report the vendor through the chat if you have any issues.',
                    confirmText: 'Start Chat',
                  );
                  if (confirmed == true) {
                    widget.onChatTapped?.call();
                  }
                },
                tooltip: 'Chat with vendor',
                color: Colors.blue,
                iconSize: iconSize,
                icon: const Icon(Icons.message_outlined),
              ),
              IconButton(
                onPressed: () async {
                  final isPending = widget.orderStatus == OrderStatus.pending;
                  final confirmed = await _showConfirmDialog(
                    context,
                    title: 'Cancel Order',
                    content: isPending
                        ? 'Are you sure you want to cancel this order? This action cannot be undone.'
                        : 'This order is already in process. Canceling it now may result in '
                              'the loss of the delivery fee. Are you sure you want to proceed?',
                    confirmText: 'Cancel',
                  );
                  if (confirmed == true) {
                    widget.onCancelTapped?.call();
                  }
                },
                tooltip: 'Cancel order',
                color: Colors.red,
                iconSize: iconSize,
                icon: const Icon(Icons.cancel_outlined),
              ),
            ],
          ),
          _ => const SizedBox.shrink(), // No buttons for other statuses
        },
      ],
    );
  }

  Widget _buildStatusIndicator() {
    Color statusColor;
    String statusText;
    switch (widget.orderStatus) {
      case OrderStatus.pending:
        statusColor = Colors.orange;
        statusText = 'Pending';
        break;
      case OrderStatus.inProcess:
        statusColor = Colors.blue;
        statusText = 'In Process';
        break;
      case OrderStatus.delivered:
        statusColor = Colors.purple;
        statusText = 'Delivered';
        break;
      case OrderStatus.accepted:
        statusColor = Colors.green;
        statusText = 'Accepted';
        break;
      case OrderStatus.rejected:
        statusColor = Colors.red;
        statusText = 'Rejected';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<bool?> _showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String confirmText,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  Future<void> _showDisputeDialog(BuildContext context) {
    // The default state is that the seller is at fault.
    // This protects the buyer and aligns with the most common reason for rejection.
    bool isSellerAtFault = true;

    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          String message = isSellerAtFault
              ? 'You will receive a **full refund**. The delivery fee will be deducted from the vendor’s earnings. '
                    'This action cannot be undone.'
              : 'You will receive a **partial refund**. The delivery fee will be deducted from your payment. '
                    'This action cannot be undone.';

          return AlertDialog(
            title: const Text('Why are you rejecting this order?'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RadioListTile<bool>(
                    title: const Text('The vendor sent the wrong item.'),
                    value: true,
                    groupValue: isSellerAtFault,
                    onChanged: (bool? value) {
                      setState(() {
                        isSellerAtFault = value ?? false;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: const Text('I have changed my mind.'),
                    value: false,
                    groupValue: isSellerAtFault,
                    onChanged: (bool? value) {
                      setState(() {
                        isSellerAtFault = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onDisputeTapped?.call(isSellerAtFault);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Reject Order'),
              ),
            ],
          );
        },
      ),
    );
  }
}
