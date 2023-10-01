class SelectProductRequestModel {
  final String depositAmount;
  final String savingFrequency;
  final String productId;
  final String groupId;
  final String subUserId;
  final String callBackUrl;

  SelectProductRequestModel({
    required this.depositAmount,
    required this.savingFrequency,
    required this.productId,
    required this.groupId,
    required this.subUserId,
    this.callBackUrl = 'https://www.kolobox.ng',
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deposit_amount'] = depositAmount;
    data['saving_frequency'] = savingFrequency;
    data['product_id'] = productId;
    data['group_id'] = groupId;
    data['subUser_id'] = subUserId;
    data['callback_url'] = callBackUrl;
    return data;
  }
}
