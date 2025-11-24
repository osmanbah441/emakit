import 'package:intl/intl.dart';

String getFormattedDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final orderDate = DateTime(date.year, date.month, date.day);

  if (orderDate == today) return 'Today';
  if (orderDate == yesterday) return 'Yesterday';

  return DateFormat('d MMM yyyy').format(date);
}
