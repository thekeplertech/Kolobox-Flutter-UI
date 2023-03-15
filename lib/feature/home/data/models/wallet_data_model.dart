class WalletDataModel {
  UserWallet? userWallet;
  List<WalletHistory>? walletHistory;
  List<TransactionHistory>? transactionHistory;

  WalletDataModel.fromJson(Map<String, dynamic> json) {
    userWallet = json['userWallet'] != null
        ? UserWallet.fromJson(json['userWallet'])
        : null;
    if (json['walletHistory'] != null) {
      walletHistory = <WalletHistory>[];
      json['walletHistory'].forEach((v) {
        walletHistory!.add(WalletHistory.fromJson(v));
      });
    }
    if (json['transactionHistory'] != null) {
      transactionHistory = <TransactionHistory>[];
      json['transactionHistory'].forEach((v) {
        transactionHistory!.add(TransactionHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userWallet != null) {
      data['userWallet'] = userWallet!.toJson();
    }
    if (walletHistory != null) {
      data['walletHistory'] = walletHistory!.map((v) => v.toJson()).toList();
    }
    if (transactionHistory != null) {
      data['transactionHistory'] =
          transactionHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserWallet {
  String? id;
  String? bookBalance;
  String? accountBalance;
  String? createdAt;
  String? updatedAt;
  String? userId;

  UserWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    bookBalance = json['book_balance'] ?? '';
    accountBalance = json['account_balance'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    userId = json['user_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['book_balance'] = bookBalance;
    data['account_balance'] = accountBalance;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_id'] = userId;
    return data;
  }
}

class WalletHistory {
  String? id;
  String? credit;
  String? debit;
  String? detail;
  String? createdAt;
  String? updatedAt;
  String? userWalletId;

  WalletHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    credit = json['credit'] ?? '';
    debit = json['debit'] ?? '';
    detail = json['detail'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    userWalletId = json['user_wallet_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['credit'] = credit;
    data['debit'] = debit;
    data['detail'] = detail;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_wallet_id'] = userWalletId;
    return data;
  }
}

class TransactionHistory {
  String? firstname;
  String? lastname;
  String? productName;
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

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'] ?? '';
    lastname = json['lastname'] ?? '';
    productName = json['product_name'] ?? '';
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
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['product_name'] = productName;
    data['id'] = id;
    data['status'] = status;
    data['deposit_amount'] = depositAmount;
    data['withdrawal_amount'] = withdrawalAmount;
    data['saving_frequency'] = savingFrequency;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_id'] = userId;
    data['product_id'] = productId;
    return data;
  }
}
