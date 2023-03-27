const String mondayValue = 'Monday';
const String tuesdayValue = 'Tuesday';
const String wednesdayValue = 'Wednesday';
const String thursdayValue = 'Thursday';
const String fridayValue = 'Friday';
const String saturdayValue = 'Saturday';
const String sundayValue = 'Sunday';

enum WeeklyEnum {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

extension WeeklyEnumExtensions on WeeklyEnum {
  String get getWeeklyValue {
    switch (this) {
      case WeeklyEnum.monday:
        return mondayValue;
      case WeeklyEnum.tuesday:
        return tuesdayValue;
      case WeeklyEnum.wednesday:
        return wednesdayValue;
      case WeeklyEnum.thursday:
        return thursdayValue;
      case WeeklyEnum.friday:
        return fridayValue;
      case WeeklyEnum.saturday:
        return saturdayValue;
      case WeeklyEnum.sunday:
        return sundayValue;
    }
  }
}
