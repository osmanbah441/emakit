enum PaymentMethodType { mobileMoney, card, cashOnDelivery }

enum MobileMoneyProvider { africell, orange }

abstract class PaymentMethod {
  final String id;
  final PaymentMethodType type;

  const PaymentMethod({required this.id, required this.type});
}

class MobileMoneyPayment extends PaymentMethod {
  final MobileMoneyProvider provider;
  final String phoneNumber;

  const MobileMoneyPayment({
    required super.id,
    required this.provider,
    required this.phoneNumber,
  }) : super(type: PaymentMethodType.mobileMoney);
}

class CardPayment extends PaymentMethod {
  final String last4Digits;
  final String brand;
  final String expiryDate; // e.g., "08/25"

  const CardPayment({
    required super.id,
    required this.last4Digits,
    required this.brand,
    required this.expiryDate,
  }) : super(type: PaymentMethodType.card);
}

class CashOnDeliveryPayment extends PaymentMethod {
  const CashOnDeliveryPayment({required super.id})
    : super(type: PaymentMethodType.cashOnDelivery);
}

enum PaymentStatus { pending, succeeded, failed }

/// Represents an actual payment transaction that has occurred.
class Payment {
  final String id;
  final String orderId;
  final double amount;
  final String currency; // e.g., "SLL"
  final String paymentMethodId;
  final PaymentStatus status;
  final DateTime timestamp;

  const Payment({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.paymentMethodId,
    required this.status,
    required this.timestamp,
  });
}
