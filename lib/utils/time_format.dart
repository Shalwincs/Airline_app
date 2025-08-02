import 'package:intl/intl.dart';

String formatFlightTime(DateTime? dt) {
  if (dt == null) return '';
  return DateFormat.Hm().format(dt); // e.g. "21:30"
}