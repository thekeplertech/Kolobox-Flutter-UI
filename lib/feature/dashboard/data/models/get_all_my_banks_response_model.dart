class GetAllMyBanksResponseModel {
  List<MyBankData>? banks;

  GetAllMyBanksResponseModel({this.banks});

  GetAllMyBanksResponseModel.fromJson(List<dynamic> data) {
    banks = <MyBankData>[];
    for (var v in data) {
      banks!.add(MyBankData.fromJson(v));
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = [];
    if (banks != null) {
      data = banks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyBankData {
  String? id;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? code;
  bool? payWithBank;
  String? recipientCode;
  String? createdAt;
  String? updatedAt;
  String? userId;

  MyBankData(
      {this.id,
      this.bankName,
      this.accountNumber,
      this.accountName,
      this.code,
      this.payWithBank,
      this.recipientCode,
      this.createdAt,
      this.updatedAt,
      this.userId});

  MyBankData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    bankName = json['bank_name'] ?? '';
    accountNumber = json['account_number'] ?? '';
    accountName = json['account_name'] ?? '';
    code = json['code'] ?? '';
    payWithBank = json['pay_with_bank'] ?? false;
    recipientCode = json['recipient_code'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    userId = json['user_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['bank_name'] = bankName ?? '';
    data['account_number'] = accountNumber ?? '';
    data['account_name'] = accountName ?? '';
    data['code'] = code ?? '';
    data['pay_with_bank'] = payWithBank ?? false;
    data['recipient_code'] = recipientCode ?? '';
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    data['user_id'] = userId ?? '';
    return data;
  }
}
