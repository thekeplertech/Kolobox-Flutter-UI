class AccountTransferResponseModel {
  String? message;
  String? duration;

  AccountTransferResponseModel({this.message, this.duration});

  AccountTransferResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    duration = json['duration'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['duration'] = duration;
    return data;
  }
}
