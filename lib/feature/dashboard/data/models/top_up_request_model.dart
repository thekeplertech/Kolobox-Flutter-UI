class TopUpRequestModel {
  final String depositAmount;
  final String productId;

  TopUpRequestModel({
    required this.depositAmount,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deposit_amount'] = depositAmount;
    data['product_id'] = productId;
    return data;
  }
}
