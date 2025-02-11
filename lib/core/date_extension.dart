import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String formatDateOnTextField() {
    final DateFormat _dateFormat = DateFormat("d MMM yyyy");
    return _dateFormat.format(this);
  }
}

extension StringExtension on String {
  DateTime getDateFromTextField() {
    final DateFormat _dateFormat = DateFormat("d MMM yyyy");
    return _dateFormat.parse(this);
  }
}
