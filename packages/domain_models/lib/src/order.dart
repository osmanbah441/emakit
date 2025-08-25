import 'package:intl/intl.dart';

class Order {
  final String id;
  final DateTime date;
  final double total;
  final int totalItems;
  final int completedItems;
  final OrderStatus status;

  Order({
    required this.id,
    required this.date,
    this.total = 0,
    this.totalItems = 0,
    this.completedItems = 0,
    this.status = OrderStatus.processing,
  });

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

enum OrderStatus { partial, processing, completed }
