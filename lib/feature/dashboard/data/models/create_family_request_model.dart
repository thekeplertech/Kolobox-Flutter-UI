class CreateFamilyRequestModel {
  final String name;
  final String tenorId;
  String groupTypeId;
  final String minimumAmount;
  final String frequency;

  CreateFamilyRequestModel({
    required this.name,
    required this.tenorId,
    required this.groupTypeId,
    required this.minimumAmount,
    required this.frequency,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['tenor_id'] = tenorId;
    data['group_type_id'] = groupTypeId;
    data['minimum_amount'] = minimumAmount;
    data['frequency'] = frequency;
    return data;
  }
}
