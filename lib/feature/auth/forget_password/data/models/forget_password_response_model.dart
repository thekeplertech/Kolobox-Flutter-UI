class ForgetPasswordResponseModel {
  String? token;
  String? message;

  ForgetPasswordResponseModel({
    this.token,
    this.message,
  });

  ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'] ?? '';
    message = json['message'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}
