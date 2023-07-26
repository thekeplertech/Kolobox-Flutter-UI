class AccountTransferRequestModel {
  final String id;
  final String amount;
  final String productId;
  final String pin;

  AccountTransferRequestModel({
    required this.id,
    required this.amount,
    required this.productId,
    required this.pin,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['product_id'] = productId;
    data['pin'] = pin;
    return data;
  }
}
