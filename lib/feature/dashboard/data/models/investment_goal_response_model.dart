class InvestmentGoalResponseModel {
  InvestmentGoalModel? investmentGoalModel;

  InvestmentGoalResponseModel({this.investmentGoalModel});

  InvestmentGoalResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;

    investmentGoalModel = InvestmentGoalModel.fromJson(json);
  }
}

class InvestmentGoalModel {
  String? dueDate;
  double? goalAmount;
  String? purpose;
  double? amountSaved;
  int? daysLeft;
  int? totalDays;
  double? percentageAmountSaved;
  double? percentageDaysUsed;

  InvestmentGoalModel(
      {this.dueDate,
      this.goalAmount,
      this.purpose,
      this.amountSaved,
      this.daysLeft,
      this.totalDays,
      this.percentageAmountSaved,
      this.percentageDaysUsed});

  InvestmentGoalModel.fromJson(Map<String, dynamic> json) {
    dueDate = json['due_date'] ?? '';
    purpose = json['purpose'] ?? '';
    goalAmount = json['goal_amount'] == null
        ? 0.0
        : double.parse(json['goal_amount'].toString());
    amountSaved = json['amount_saved'] == null
        ? 0.0
        : double.parse(json['amount_saved'].toString());
    daysLeft = json['days_left'] ?? 0;
    totalDays = json['totalDays'] ?? 0;
    percentageAmountSaved = json['percentageAmountSaved'] == null
        ? 0.0
        : double.parse(json['percentageAmountSaved'].toString());
    percentageDaysUsed = json['percentageDaysUsed'] == null
        ? 0.0
        : double.parse(json['percentageDaysUsed'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['due_date'] = dueDate ?? '';
    data['goal_amount'] = goalAmount ?? 0.0;
    data['purpose'] = purpose ?? '';
    data['amount_saved'] = amountSaved ?? 0.0;
    data['days_left'] = daysLeft ?? 0;
    data['totalDays'] = totalDays ?? 0;
    data['percentageAmountSaved'] = percentageAmountSaved ?? 0.0;
    data['percentageDaysUsed'] = percentageDaysUsed ?? 0.0;
    return data;
  }
}
