import 'package:intl/intl.dart';

extension FormatString on String {
  String format(String pattern) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}