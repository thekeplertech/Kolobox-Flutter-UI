class EarningsDataModel {
  List<EarningsData>? products;

  EarningsDataModel({this.products});

  EarningsDataModel.fromJson(List<dynamic> data) {
    products = <EarningsData>[];
    for (var v in data) {
      products!.add(EarningsData.fromJson(v));
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

class EarningsData {
  String? id;
  String? earning;
  String? amount;
  String? date;
  String? createdAt;
  String? updatedAt;
  String? userProductId;

  EarningsData(
      {this.id,
      this.earning,
      this.amount,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.userProductId});

  EarningsData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    earning = json['earning'] ?? '';
    amount = json['amount'] ?? '';
    date = json['date'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    userProductId = json['user_product_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['earning'] = earning ?? '';
    data['amount'] = amount ?? '';
    data['date'] = date ?? '';
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    data['user_product_id'] = userProductId ?? '';
    return data;
  }
}
