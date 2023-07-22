class CreateFamilyResponseModel {
  String? id;
  String? name;
  SubUser? subUser;

  CreateFamilyResponseModel({this.id, this.name, this.subUser});

  CreateFamilyResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    subUser =
        json['subUser'] != null ? SubUser.fromJson(json['subUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['name'] = name ?? '';
    if (subUser != null) {
      data['subUser'] = subUser!.toJson();
    }
    return data;
  }
}

class SubUser {
  String? id;

  SubUser({this.id});

  SubUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
