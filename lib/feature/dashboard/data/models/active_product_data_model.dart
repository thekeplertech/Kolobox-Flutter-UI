class ActiveProductDataModel {
  List<Data>? products;

  ActiveProductDataModel({this.products});

  ActiveProductDataModel.fromJson(List<dynamic> data) {
    products = <Data>[];
    for (var v in data) {
      products!.add(Data.fromJson(v));
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = [];
    if (products != null) {
      data = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? depositAmount;
  String? startDate;
  String? savingFrequency;
  bool? verified;
  bool? canceled;
  String? createdAt;
  String? updatedAt;
  String? productId;
  String? userId;

  Data(
      {this.id,
      this.depositAmount,
      this.startDate,
      this.savingFrequency,
      this.verified,
      this.canceled,
      this.createdAt,
      this.updatedAt,
      this.productId,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    depositAmount = json['deposit_amount'] ?? '';
    startDate = json['start_date'] ?? '';
    savingFrequency = json['saving_frequency'] ?? '';
    verified = json['verified'] ?? false;
    canceled = json['canceled'] ?? false;
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    productId = json['product_id'] ?? '';
    userId = json['user_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['deposit_amount'] = depositAmount ?? '';
    data['start_date'] = startDate ?? '';
    data['saving_frequency'] = savingFrequency ?? '';
    data['verified'] = verified ?? false;
    data['canceled'] = canceled ?? false;
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    data['product_id'] = productId ?? '';
    data['user_id'] = userId ?? '';
    return data;
  }
}
