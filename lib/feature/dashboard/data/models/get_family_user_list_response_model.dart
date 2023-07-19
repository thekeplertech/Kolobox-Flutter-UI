class GetFamilyUserListResponseModel {
  List<FamilyUserModel>? users;

  GetFamilyUserListResponseModel({this.users});

  GetFamilyUserListResponseModel.fromJson(List<dynamic> data) {
    users = <FamilyUserModel>[];
    for (var v in data) {
      users!.add(FamilyUserModel.fromJson(v));
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = [];
    if (users != null) {
      data = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FamilyUserModel {
  String? firstname;
  String? subUserId;
  String? relation;
  String? userId;
  int? groupDeposit;

  FamilyUserModel({
    this.firstname,
    this.subUserId,
    this.relation,
    this.userId,
    this.groupDeposit,
  });

  FamilyUserModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'] ?? '';
    subUserId = json['subUser_id'];
    relation = json['relation'] ?? '';
    userId = json['user_id'] ?? '';
    groupDeposit = json['group_deposit'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname ?? '';
    data['subUser_id'] = subUserId ?? '';
    data['relation'] = relation ?? '';
    data['user_id'] = userId ?? '';
    data['group_deposit'] = groupDeposit ?? 0;
    return data;
  }
}
