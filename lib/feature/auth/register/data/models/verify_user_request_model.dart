class VerifyUserRequestModel {
  String id;
  final String code;

  VerifyUserRequestModel({
    required this.id,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    return data;
  }
}
