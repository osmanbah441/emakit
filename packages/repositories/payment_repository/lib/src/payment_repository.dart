import 'package:domain_models/domain_models.dart';
import 'mock_repository.dart';

abstract class PaymentRepository {
  static PaymentRepository instance = MockPaymentRepositoryImpl();

  Future<List<PaymentMethod>> getPaymentMethods();

  Future<void> addMobileMoneyPayment({
    required String provider,
    required String phoneNumber,
  });

  Future<void> addCardPayment({
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  });

  Future<void> deletePaymentMethod(String paymentMethodId);

  Future<Payment> processPayment({
    required String orderId,
    required double amount,
    required String paymentMethodId,
  });
}
