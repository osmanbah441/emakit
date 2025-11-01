import 'package:wallet/src/models/models.dart';

class CashoutDetails {
  final String phoneNumber;
  final MobileMoneyProvider provider;
  final double amount;
  final double total;
  final double fee;

  const CashoutDetails({
    required this.phoneNumber,
    required this.provider,
    required this.amount,
    required this.total,
    required this.fee,
  });
}
