class AddBankRequestModel {
  final String bankName;
  final String accountNumber;
  final String accountName;
  final String bankCode;
  final String payWithBank;

  AddBankRequestModel({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.bankCode,
    required this.payWithBank,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['account_name'] = accountName;
    data['bank_code'] = bankCode;
    data['pay_with_bank'] = payWithBank;
    return data;
  }
}
