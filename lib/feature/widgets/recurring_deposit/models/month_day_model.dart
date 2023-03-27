class MonthDayModel {
  final int day;
  final bool isSelectable;
  bool isSelected = false;

  MonthDayModel({
    required this.day,
    this.isSelectable = true,
    this.isSelected = false,
  });
}
