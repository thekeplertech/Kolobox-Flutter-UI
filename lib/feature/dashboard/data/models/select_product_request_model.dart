class SelectProductRequestModel {
  final String depositAmount;
  final String savingFrequency;
  final String productId;

  SelectProductRequestModel({
    required this.depositAmount,
    required this.savingFrequency,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deposit_amount'] = depositAmount;
    data['saving_frequency'] = savingFrequency;
    data['product_id'] = productId;
    return data;
  }
}
