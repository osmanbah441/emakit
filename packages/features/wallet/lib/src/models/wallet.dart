class Balance {
  const Balance(this.currency, {required this.amount});
  final double amount;
  final String currency;

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(json['currency'], amount: json['value'].toDouble());
  }
}

class UssdFundTransferRequest {
  final String name;
  final Balance amount;
  final DateTime expireTime;
  final String ussdCode;

  const UssdFundTransferRequest({
    required this.name,
    required this.amount,
    required this.expireTime,
    required this.ussdCode,
  });

  factory UssdFundTransferRequest.fromJson(Map<String, dynamic> json) {
    return UssdFundTransferRequest(
      name: json['name'] as String,
      amount: Balance.fromJson(json['amount'] as Map<String, dynamic>),
      expireTime: DateTime.parse(json['expireTime']),
      ussdCode: json['ussdCode'] as String,
    );
  }
}
