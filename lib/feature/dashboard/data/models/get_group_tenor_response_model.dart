class GetGroupTenorResponseModel {
  List<GroupTenorModel>? tenors;

  GetGroupTenorResponseModel({this.tenors});

  GetGroupTenorResponseModel.fromJson(List<dynamic> data) {
    tenors = <GroupTenorModel>[];
    for (var v in data) {
      tenors!.add(GroupTenorModel.fromJson(v));
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = [];
    if (tenors != null) {
      data = tenors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupTenorModel {
  String? id;
  String? tenor;
  String? createdAt;
  String? updatedAt;

  GroupTenorModel({this.id, this.tenor, this.createdAt, this.updatedAt});

  GroupTenorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    tenor = json['Tenor'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['Tenor'] = tenor ?? '';
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    return data;
  }
}
