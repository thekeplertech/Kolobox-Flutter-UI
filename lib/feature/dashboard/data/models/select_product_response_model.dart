class SelectProductResponseModel {
  String? message;
  PayStackData? data;

  SelectProductResponseModel({this.message, this.data});

  SelectProductResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    data = json['data'] != null ? PayStackData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PayStackData {
  String? authorizationUrl;
  String? accessCode;
  String? reference;

  PayStackData({this.authorizationUrl, this.accessCode, this.reference});

  PayStackData.fromJson(Map<String, dynamic> json) {
    authorizationUrl = json['authorization_url'] ?? '';
    accessCode = json['access_code'] ?? '';
    reference = json['reference'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorization_url'] = authorizationUrl ?? '';
    data['access_code'] = accessCode ?? '';
    data['reference'] = reference ?? '';
    return data;
  }
}
