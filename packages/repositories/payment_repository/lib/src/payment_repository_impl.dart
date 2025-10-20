import 'package:domain_models/domain_models.dart';
import 'payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  const PaymentRepositoryImpl();

  @override
  Future<List<PaymentMethod>> getPaymentMethods() {
    throw UnimplementedError();
  }

  @override
  Future<void> addMobileMoneyPayment({
    required String provider,
    required String phoneNumber,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> addCardPayment({
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) {
    // This would integrate with a payment gateway like Stripe
    throw UnimplementedError();
  }

  @override
  Future<void> deletePaymentMethod(String paymentMethodId) {
    throw UnimplementedError();
  }

  @override
  Future<Payment> processPayment({
    required String orderId,
    required double amount,
    required String paymentMethodId,
  }) {
    throw UnimplementedError();
  }
}
