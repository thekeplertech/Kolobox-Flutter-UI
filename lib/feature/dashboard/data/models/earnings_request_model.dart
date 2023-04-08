class EarningsRequestModel {
  final String userProductId;

  EarningsRequestModel({
    required this.userProductId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_product_id'] = userProductId;
    return data;
  }
}
