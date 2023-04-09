class TransactionsDataModel {
  List<Transactions>? transactions;

  TransactionsDataModel({this.transactions});

  TransactionsDataModel.fromJson(List<dynamic> data) {
    transactions = <Transactions>[];
    for (var v in data) {
      transactions!.add(Transactions.fromJson(v));
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = [];
    if (transactions != null) {
      data = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? id;
  bool? status;
  String? depositAmount;
  String? withdrawalAmount;
  String? savingFrequency;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? userId;
  String? productId;

  Transactions({
    this.id,
    this.status,
    this.depositAmount,
    this.withdrawalAmount,
    this.savingFrequency,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.productId,
  });

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    status = json['status'] ?? false;
    depositAmount = json['deposit_amount'] ?? '';
    withdrawalAmount = json['withdrawal_amount'] ?? '';
    savingFrequency = json['saving_frequency'] ?? '';
    type = json['type'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    userId = json['user_id'] ?? '';
    productId = json['product_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['status'] = status ?? false;
    data['deposit_amount'] = depositAmount ?? '';
    data['withdrawal_amount'] = withdrawalAmount ?? '';
    data['saving_frequency'] = savingFrequency ?? '';
    data['type'] = type ?? '';
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    data['user_id'] = userId ?? '';
    data['product_id'] = productId ?? '';
    return data;
  }
}
