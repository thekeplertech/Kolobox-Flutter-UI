class TransactionsRequestModel {
  final String productId;

  TransactionsRequestModel({
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    return data;
  }
}
