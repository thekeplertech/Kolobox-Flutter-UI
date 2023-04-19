class DeleteBankRequestModel {
  final String pin;

  DeleteBankRequestModel({
    required this.pin,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pin'] = pin;
    return data;
  }
}
