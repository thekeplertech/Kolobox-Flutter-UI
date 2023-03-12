class ValidateRequestModel {
  final String code;

  ValidateRequestModel({
    required this.code,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    return data;
  }
}
