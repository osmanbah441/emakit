import 'dart:math';

import 'package:payment_repository/payment_repository.dart';
import 'package:domain_models/domain_models.dart';

class MockPaymentRepositoryImpl implements PaymentRepository {
  final List<PaymentMethod> _methods = [];

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    return List.unmodifiable(_methods);
  }

  @override
  Future<void> addMobileMoneyPayment({
    required String provider,
    required String phoneNumber,
  }) async {
    final newMethod = MobileMoneyPayment(
      id: Random().nextInt(9999).toString(),
      provider: MobileMoneyProvider.values.firstWhere(
        (p) => p.name == provider,
      ),
      phoneNumber: phoneNumber,
    );
    _methods.add(newMethod);
  }

  @override
  Future<void> addCardPayment({
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) async {
    final newMethod = CardPayment(
      id: Random().nextInt(9999).toString(),
      last4Digits: cardNumber.substring(cardNumber.length - 4),
      brand: 'Visa', // Mock brand
      expiryDate: expiryDate,
    );
    _methods.add(newMethod);
  }

  @override
  Future<void> deletePaymentMethod(String paymentMethodId) async {
    _methods.removeWhere((m) => m.id == paymentMethodId);
  }

  @override
  Future<Payment> processPayment({
    required String orderId,
    required double amount,
    required String paymentMethodId,
  }) async {
    return Payment(
      id: 'mock-payment-${Random().nextInt(9999)}',
      orderId: orderId,
      amount: amount,
      currency: 'SLL',
      paymentMethodId: paymentMethodId,
      status: PaymentStatus.succeeded,
      timestamp: DateTime.now(),
    );
  }
}
