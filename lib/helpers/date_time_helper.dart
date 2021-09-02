import 'package:intl/intl.dart';

bool isSameDay(DateTime firstDateTime, DateTime secondDateTime) {
  return (firstDateTime.year == secondDateTime.year &&
      firstDateTime.month == secondDateTime.month &&
      firstDateTime.day == secondDateTime.day);
}

// toPrettyString will format a date time to a nicely readable string
String toPrettyString(DateTime? dateTime) {
  // Return today if it was done today
  if (dateTime == null) {
    return "";
  }
  if (isSameDay(DateTime.now(), dateTime)) {
    return "Today";
  }
  // Return yesterday if it was done yesterday
  if (isSameDay(DateTime.now().subtract(Duration(days: 1)), dateTime)) {
    return "Yesterday";
  }
  // Don't display the year if it's this year
  if (DateTime.now().year == dateTime.year) {
    return DateFormat('MMMM dd').format(dateTime);
  }
  return DateFormat('MMMM dd yyyy').format(dateTime);
}

String getTimeString(DateTime? dateTime) {
  if (dateTime == null) {
    return "";
  }
  return DateFormat('HH:mm').format(dateTime).toString();
}

String getDayAndTimeString(DateTime? dateTime) {
  return toPrettyString(dateTime) + " at " + getTimeString(dateTime);
}
