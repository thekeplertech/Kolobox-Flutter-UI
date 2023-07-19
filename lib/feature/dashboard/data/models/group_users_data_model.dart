class GroupUsersDataModel {
  List<GroupUsers>? users;

  GroupUsersDataModel({this.users});

  GroupUsersDataModel.fromJson(List<dynamic> data) {
    users = <GroupUsers>[];
    for (var v in data) {
      users!.add(GroupUsers.fromJson(v));
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

class GroupUsers {
  String? userName;
  String? userId;
  String? tenor;
  bool? groupAdmin;
  int? groupDeposit;

  GroupUsers({
    this.userName,
    this.userId,
    this.tenor,
    this.groupAdmin,
    this.groupDeposit,
  });

  GroupUsers.fromJson(Map<String, dynamic> json) {
    userName = json['userName'] ?? '';
    userId = json['userId'] ?? '';
    tenor = json['tenor'] ?? '';
    groupAdmin = json['groupAdmin'] ?? false;
    groupDeposit = json['group_deposit'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName ?? '';
    data['userId'] = userId ?? '';
    data['tenor'] = tenor ?? '';
    data['groupAdmin'] = groupAdmin ?? false;
    data['group_deposit'] = groupDeposit ?? 0;
    return data;
  }
}
