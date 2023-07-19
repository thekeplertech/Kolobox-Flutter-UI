class GroupInviteRequestModel {
  final String groupId;
  final String email;

  GroupInviteRequestModel({
    required this.groupId,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['email'] = email;
    return data;
  }
}
