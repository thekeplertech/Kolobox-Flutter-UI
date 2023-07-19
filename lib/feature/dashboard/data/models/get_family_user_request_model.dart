class GetFamilyUserRequestModel {
  final String groupId;

  GetFamilyUserRequestModel({
    required this.groupId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    return data;
  }
}
