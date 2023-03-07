import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static String getTextFromDateTime(DateTime dateTime, String format) =>
      DateFormat(format, 'es').format(dateTime);

  static bool isToday(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime first = DateTime(dateTime.year, dateTime.month, dateTime.day);
    return first == now;
  }
}
