import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static String getTextFromDateTime(DateTime dateTime, String format) =>
      DateFormat(format).format(dateTime);

  static DateTime getDateTime(String dateTime) => DateTime.parse(dateTime);

  static String getDateFromDateTime(String? dateTime, String format) {
    if ((dateTime ?? '').isEmpty) return '';
    return DateFormat(format).format(DateTime.parse(dateTime!));
  }

  static bool isToday(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime first = DateTime(dateTime.year, dateTime.month, dateTime.day);
    return first == now;
  }
}
