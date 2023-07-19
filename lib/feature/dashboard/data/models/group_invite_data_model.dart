class GroupInviteDataModel {
  String? message;
  bool? status;

  GroupInviteDataModel({
    this.message,
    this.status,
  });

  GroupInviteDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    status = json['status'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message ?? '';
    data['status'] = status ?? false;
    return data;
  }
}
