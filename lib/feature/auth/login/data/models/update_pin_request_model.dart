class UpdatePinRequestModel {
  final String oldPin;
  final String newPin;

  UpdatePinRequestModel({
    required this.oldPin,
    required this.newPin,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['old_pin'] = oldPin;
    data['new_pin'] = newPin;
    return data;
  }
}
