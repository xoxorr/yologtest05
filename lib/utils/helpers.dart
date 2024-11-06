import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatTime(DateTime date) {
  return DateFormat('HH:mm').format(date);
}

void printDebug(String message) {
  print('[DEBUG] $message');
}
