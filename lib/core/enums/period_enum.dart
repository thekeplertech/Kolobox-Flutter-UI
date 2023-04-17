const String monthlyValue = 'Monthly';
const String weeklyValue = 'Weekly';
const String dailyValue = 'Daily';

const String monthlyPassValue = 'monthly';
const String weeklyPassValue = 'weekly';
const String dailyPassValue = 'daily';

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

  String get getPeriodPassValue {
    switch (this) {
      case PeriodEnum.monthly:
        return monthlyPassValue;
      case PeriodEnum.weekly:
        return weeklyPassValue;
      case PeriodEnum.daily:
        return dailyPassValue;
    }
  }
}
