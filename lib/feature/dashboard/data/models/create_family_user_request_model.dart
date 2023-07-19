class CreateFamilyUserRequestModel {
  final String firstName;
  final String relation;
  final String groupId;

  CreateFamilyUserRequestModel({
    required this.firstName,
    required this.relation,
    required this.groupId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstName;
    data['relation'] = relation;
    data['group_id'] = groupId;
    return data;
  }
}
