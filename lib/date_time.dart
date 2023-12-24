import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String format() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
