class MyEarningDataModel {
  List<MyEarningsData>? earnings;

  MyEarningDataModel({this.earnings});

  MyEarningDataModel.fromJson(List<dynamic> data) {
    earnings = <MyEarningsData>[];
    for (var v in data) {
      earnings!.add(MyEarningsData.fromJson(v));
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = [];
    if (earnings != null) {
      data = earnings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyEarningsData {
  double? amount;
  String? id;
  String? groupId;
  String? startDate;
  bool? canceled;
  bool? verified;
  String? name;
  String? interestRate;
  int? tenor;
  int? topup;
  double? interest;
  String? endStart;

  MyEarningsData(
      {this.amount,
      this.id,
      this.groupId,
      this.startDate,
      this.canceled,
      this.verified,
      this.name,
      this.interestRate,
      this.tenor,
      this.topup,
      this.interest,
      this.endStart});

  MyEarningsData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] == null
        ? 0.0
        : double.tryParse(json['amount'].toString());
    id = json['id'] ?? '';
    groupId = json['group_id'] ?? '';
    startDate = json['start_date'] ?? '';
    canceled = json['canceled'] ?? false;
    verified = json['verified'] ?? false;
    name = json['name'] ?? '';
    interestRate = json['interest_rate'] ?? '';
    tenor = json['tenor'] ?? 0;
    topup = json['topup'] ?? 0;
    interest = json['interest'] == null
        ? 0.0
        : double.tryParse(json['interest'].toString());
    endStart = json['end_start'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['id'] = id;
    data['group_id'] = groupId;
    data['start_date'] = startDate;
    data['canceled'] = canceled;
    data['verified'] = verified;
    data['name'] = name;
    data['interest_rate'] = interestRate;
    data['tenor'] = tenor;
    data['topup'] = topup;
    data['interest'] = interest;
    data['end_start'] = endStart;
    return data;
  }
}
