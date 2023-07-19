class GroupTransactionsDataModel {
  List<GroupTransactions>? transactions;

  GroupTransactionsDataModel({this.transactions});

  GroupTransactionsDataModel.fromJson(List<dynamic> data) {
    transactions = <GroupTransactions>[];
    for (var v in data) {
      transactions!.add(GroupTransactions.fromJson(v));
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

class GroupTransactions {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? transactionId;
  String? productId;
  String? groupId;
  String? userId;
  String? firstName;
  String? groupName;
  String? name;
  int? maxThreshold;
  int? activeThreshold;
  String? groupTypeId;
  String? totalAmount;
  String? productName;
  String? unitProduct;
  int? productTenor;
  String? productInterest;

  GroupTransactions(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.transactionId,
      this.productId,
      this.groupId,
      this.userId,
      this.firstName,
      this.groupName,
      this.name,
      this.maxThreshold,
      this.activeThreshold,
      this.groupTypeId,
      this.totalAmount,
      this.productName,
      this.unitProduct,
      this.productTenor,
      this.productInterest});

  GroupTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    transactionId = json['transaction_id'] ?? '';
    productId = json['product_id'] ?? '';
    groupId = json['group_id'] ?? '';
    userId = json['user_id'] ?? '';
    firstName = json['firstname'] ?? '';
    groupName = json['groupname'] ?? '';
    name = json['Name'] ?? '';
    maxThreshold = json['max_threshold'] ?? 0;
    activeThreshold = json['active_threshold'] ?? 0;
    groupTypeId = json['group_type_id'] ?? '';
    totalAmount = json['totalamount'] ?? '';
    productName = json['productname'] ?? '';
    unitProduct = json['unitproduct'] ?? '';
    productTenor = json['product_tenor'] ?? 0;
    productInterest = json['productinterest'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    data['transaction_id'] = transactionId ?? '';
    data['product_id'] = productId ?? '';
    data['group_id'] = groupId ?? '';
    data['user_id'] = userId ?? '';
    data['firstname'] = firstName ?? '';
    data['groupname'] = groupName ?? '';
    data['Name'] = name ?? '';
    data['max_threshold'] = maxThreshold ?? 0;
    data['active_threshold'] = activeThreshold ?? 0;
    data['group_type_id'] = groupTypeId ?? '';
    data['totalamount'] = totalAmount ?? '';
    data['productname'] = productName ?? '';
    data['unitproduct'] = unitProduct ?? '';
    data['product_tenor'] = productTenor ?? 0;
    data['productinterest'] = productInterest ?? '';
    return data;
  }
}
