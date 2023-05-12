class GetGroupTypeResponseModel {
  List<GroupTypeModel>? types;

  GetGroupTypeResponseModel({this.types});

  GetGroupTypeResponseModel.fromJson(List<dynamic> data) {
    types = <GroupTypeModel>[];
    for (var v in data) {
      types!.add(GroupTypeModel.fromJson(v));
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = [];
    if (types != null) {
      data = types!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupTypeModel {
  String? id;
  String? name;

  GroupTypeModel({this.id, this.name});

  GroupTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['Name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['Name'] = name ?? '';
    return data;
  }
}
