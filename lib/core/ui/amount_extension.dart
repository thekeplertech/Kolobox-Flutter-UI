extension AmountExtension on String? {
  String getAmount() {
    if (this == null) {
      return '';
    }

    try {
      double amount = double.parse(this!);
      return amount.toStringAsFixed(2);
    } catch (e) {
      return '';
    }
  }
}
