class VerifyPinRequestModel {
  final String userId;
  final String pin;

  VerifyPinRequestModel({
    required this.userId,
    required this.pin,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['pin'] = pin;
    return data;
  }
}
