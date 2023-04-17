class CreateInvestmentGoalRequestModel {
  final String purpose;
  final String amount;
  final String dueDate;

  CreateInvestmentGoalRequestModel({
    required this.purpose,
    required this.amount,
    required this.dueDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['purpose'] = purpose;
    data['amount'] = amount;
    data['due_date'] = dueDate;
    return data;
  }
}
