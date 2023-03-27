const String monthlyValue = 'Monthly';
const String weeklyValue = 'Weekly';
const String dailyValue = 'Daily';

enum PeriodEnum { monthly, weekly, daily }

extension PeriodEnumExtensions on PeriodEnum {
  String get getPeriodValue {
    switch (this) {
      case PeriodEnum.monthly:
        return monthlyValue;
      case PeriodEnum.weekly:
        return weeklyValue;
      case PeriodEnum.daily:
        return dailyValue;
    }
  }
}
