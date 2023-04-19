class UpdateBankRequestModel {
  final String bankName;
  final String accountNumber;
  final String accountName;
  final String pin;
  final String code;
  final String payWithBank;

  UpdateBankRequestModel({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.pin,
    required this.code,
    required this.payWithBank,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['account_name'] = accountName;
    data['pin'] = pin;
    data['code'] = code;
    data['pay_with_bank'] = payWithBank;
    return data;
  }
}
