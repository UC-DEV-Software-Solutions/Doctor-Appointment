import 'package:intl/intl.dart';

const webScrenSize = 600;

// Format the date without time
String getFormattedDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date); // Format as "YYYY-MM-DD"
}