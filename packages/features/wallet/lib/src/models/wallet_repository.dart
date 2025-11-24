import 'dart:async';
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet/src/models/models.dart';

class WalletRepository {
  WalletRepository._();

  static final instance = WalletRepository._();
  final _client = Supabase.instance.client;

  Future<Balance> getBalance(String walletId) async => await _client.functions
      .invoke('baz-wallet/wallet/$walletId', method: HttpMethod.get)
      .then((res) {
        final data = jsonDecode(res.data) as Map<String, dynamic>;
        return Balance.fromJson(data);
      });

  Future<void> checkout({
    required String userId,
    required String userWalletId,
    required String userPhoneNumber,
    required String? cartItemId,
  }) async {
    try {
      await _client.functions.invoke(
        'baz-wallet/checkout',
        body: {
          "userId": userId,
          "userWalletId": userWalletId,
          "userPhoneNumber": userPhoneNumber,
          if (cartItemId != null) "cartItemId": cartItemId,
        },
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UssdFundTransferRequest> mobileCashIn(
    double amount,
    String walletId,
  ) async {
    try {
      return await _client.functions
          .invoke(
            'baz-wallet/mobile-money-payin',
            body: {'amount': amount, 'walletId': walletId},
          )
          .then((res) {
            final data = res.data as Map<String, dynamic>;
            return UssdFundTransferRequest.fromJson(data);
          });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> mobileCashOut({
    required String phoneNumber,
    required MobileMoneyProvider provider,
    required double amount,
    required String walletId,
  }) async {
    try {
      await _client.functions.invoke(
        'baz-wallet/mobile-money-cashout',
        body: {
          'phoneNumber': phoneNumber,
          'providerId': provider.providerId,
          'walletId': walletId,
          'amount': amount,
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
