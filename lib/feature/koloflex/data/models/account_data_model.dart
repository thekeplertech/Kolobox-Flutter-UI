class AccountDataModel {
  final String name;
  final String amount;
  final int totalTenor;
  final int remainingTenor;
  final String startDate;

  AccountDataModel(
      {required this.name,
      required this.amount,
      required this.totalTenor,
      required this.remainingTenor,
      required this.startDate});
}
