class TopUpResponseModel {
  String? message;
  TopUpData? topUpData;
  String? productId;

  TopUpResponseModel({this.message, this.topUpData, this.productId});

  TopUpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    topUpData = json['top_up_data'] != null
        ? TopUpData.fromJson(json['top_up_data'])
        : null;
    productId = json['product_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (topUpData != null) {
      data['top_up_data'] = topUpData!.toJson();
    }
    data['product_id'] = productId;
    return data;
  }
}

class TopUpData {
  String? authorizationUrl;
  String? accessCode;
  String? reference;

  TopUpData({this.authorizationUrl, this.accessCode, this.reference});

  TopUpData.fromJson(Map<String, dynamic> json) {
    authorizationUrl = json['authorization_url'] ?? '';
    accessCode = json['access_code'] ?? '';
    reference = json['reference'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorization_url'] = authorizationUrl;
    data['access_code'] = accessCode;
    data['reference'] = reference;
    return data;
  }
}
