class TopUpRequestModel {
  final String depositAmount;
  final String productId;
  final String groupId;

  TopUpRequestModel({
    required this.depositAmount,
    required this.productId,
    required this.groupId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deposit_amount'] = depositAmount;
    data['product_id'] = productId;
    data['group_id'] = groupId;
    return data;
  }
}
