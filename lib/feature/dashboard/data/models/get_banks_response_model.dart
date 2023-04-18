class GetBanksResponseModel {
  int? count;
  List<BankData>? data;

  GetBanksResponseModel({this.count, this.data});

  GetBanksResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'] ?? 0;
    data = <BankData>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(BankData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count ?? 0;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankData {
  int? id;
  String? name;
  String? slug;
  String? code;
  String? longCode;
  String? gateway;
  bool? payWithBank;
  bool? active;
  String? country;
  String? currency;
  String? type;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  BankData(
      {this.id,
      this.name,
      this.slug,
      this.code,
      this.longCode,
      this.gateway,
      this.payWithBank,
      this.active,
      this.country,
      this.currency,
      this.type,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  BankData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    slug = json['slug'] ?? '';
    code = json['code'] ?? '';
    longCode = json['longcode'] ?? '';
    gateway = json['gateway'] ?? '';
    payWithBank = json['pay_with_bank'] ?? false;
    active = json['active'] ?? false;
    country = json['country'] ?? '';
    currency = json['currency'] ?? '';
    type = json['type'] ?? '';
    isDeleted = json['is_deleted'] ?? false;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? 0;
    data['name'] = name ?? '';
    data['slug'] = slug ?? '';
    data['code'] = code ?? '';
    data['longcode'] = longCode ?? '';
    data['gateway'] = gateway ?? '';
    data['pay_with_bank'] = payWithBank ?? false;
    data['active'] = active ?? false;
    data['country'] = country ?? '';
    data['currency'] = currency ?? '';
    data['type'] = type ?? '';
    data['is_deleted'] = isDeleted ?? false;
    data['createdAt'] = createdAt ?? '';
    data['updatedAt'] = updatedAt ?? '';
    return data;
  }
}
