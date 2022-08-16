import 'package:intl/intl.dart';

class DateFormating {
  static String formatDate(DateTime time) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    final String formatted = formatter.format(time);
    return formatted;
  }
}
