import 'package:domain_models/domain_models.dart';
import 'package:intl/intl.dart';

enum OrderStatus {
  pending, // Order placed, awaiting confirmation
  inProcess, // Order confirmed, being prepared/picked
  shipped, // Order has left the warehouse/seller
  delivered, // Order has arrived at the delivery address
  accepted, // Order has been accepted by the customer (e.g., services)
  rejected, // Order cancelled or rejected
}

class OrderItem {
  final String id;
  final StoreVariation variantSnapshot;
  final int quantity;
  final OrderStatus status;
  final double unitPrice;

  const OrderItem({
    required this.id,
    required this.variantSnapshot,
    required this.quantity,
    this.unitPrice = 0.0,
    this.status = OrderStatus.inProcess,
  });

  double get lineTotal => unitPrice * quantity;
}

class Order {
  final String id;
  final String userId;
  final DateTime date;
  final List<OrderItem> items;
  final Address deliveryAddress;
  final double shippingCost;
  final double taxRate;
  final OrderStatus status;

  Order({
    required this.id,
    required this.userId,
    required this.date,
    required this.items,
    required this.deliveryAddress,
    this.shippingCost = 0.0,
    this.taxRate = 0.0,
    this.status = OrderStatus.pending,
  });

  double get subtotal {
    return items.fold(0.0, (sum, item) => sum + item.lineTotal);
  }

  double get taxAmount {
    return subtotal * taxRate;
  }

  double get total {
    return subtotal + taxAmount + shippingCost;
  }

  int get totalItemsCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  int get completedItemsCount {
    const Set<OrderStatus> completedStatuses = {
      OrderStatus.shipped,
      OrderStatus.delivered,
      OrderStatus.accepted,
    };

    return items.fold(0, (sum, item) {
      if (completedStatuses.contains(item.status)) {
        return sum + item.quantity;
      }
      return sum;
    });
  }

  String getFormattedDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final orderDate = DateTime(date.year, date.month, date.day);

    if (orderDate == today) return 'Today';
    if (orderDate == yesterday) return 'Yesterday';

    return DateFormat('d MMM yyyy').format(date);
  }
}
