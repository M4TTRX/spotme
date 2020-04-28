import 'package:intl/intl.dart';

bool isSameDay(DateTime firstDateTime, DateTime secondDateTime) {
  return (firstDateTime.year == secondDateTime.year &&
      firstDateTime.month == secondDateTime.month &&
      firstDateTime.day == secondDateTime.day);
}

String toPrettyString(DateTime dateTime) {
  if (isSameDay(DateTime.now(), dateTime)) {
    return "Today";
  }
  if (isSameDay(DateTime.now().subtract(Duration(days: 1)), dateTime)) {
    return "Yesterday";
  }
  if (DateTime.now().year == dateTime.year) {
    return DateFormat('MMMM dd').format(dateTime);
  }
  return DateFormat('MMMM dd yyyy').format(dateTime);
}
