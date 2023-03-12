class ForgetPasswordRequestModel {
  final String emailPhone;

  ForgetPasswordRequestModel({
    required this.emailPhone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emailPhone'] = emailPhone;
    return data;
  }
}
