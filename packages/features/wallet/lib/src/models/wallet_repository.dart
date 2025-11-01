import 'dart:async';
import 'package:wallet/src/models/deposit_details.dart';

class WalletRepository {
  const WalletRepository._();

  static const instance = WalletRepository._();

  static double _balance = 0.0;

  Future<double> getBalance() async {
    await Future.delayed(const Duration(seconds: 2));

    return _balance;
  }

  Future<void> pay({required double amount}) async {
    await Future.delayed(const Duration(seconds: 2));

    if (_balance < amount) {
      throw ('Insufficient funds');
    }

    _balance -= amount;
  }

  Future<DepositDetails> addMoney(double amount) async {
    await Future.delayed(const Duration(seconds: 2));

    _balance += amount;

    return DepositDetails(
      transactionId: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
      ussdCode: '*123*456*789#', // Simulated USSD code
      providerName: 'Orange Money',
      initialCountdownSeconds: 10, // *** CHANGED TO 10 SECONDS FOR TESTING ***
      depositAmount: amount, // Amount passed through
    );
  }

  Future<void> processCashout({
    required String phoneNumber,
    required String provider,
    required double amount,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if (_balance < amount) {
      throw ('Insufficient funds');
    }

    _balance -= amount;
  }
}
