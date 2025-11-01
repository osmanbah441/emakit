class PaymentFailedException implements Exception {
  final String message;
  const PaymentFailedException(this.message);
}

class CashoutFailedException implements Exception {
  final String message;
  const CashoutFailedException(this.message);
}
