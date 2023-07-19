class TopUpRequestModel {
  final String depositAmount;
  final String productId;
  final String groupId;
  final String subUserId;

  TopUpRequestModel({
    required this.depositAmount,
    required this.productId,
    required this.groupId,
    required this.subUserId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deposit_amount'] = depositAmount;
    data['product_id'] = productId;
    data['group_id'] = groupId;
    data['subUser_id'] = subUserId;
    return data;
  }
}
