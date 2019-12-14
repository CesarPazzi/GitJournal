import 'dart:core';
import 'package:intl/intl.dart';

String toIso8601(DateTime dt) {
  return DateFormat("yyyy-MM-ddTHH:mm:ss").format(dt);
}

String toIso8601WithTimezone(DateTime dt, [Duration offset]) {
  var result = DateFormat("yyyy-MM-ddTHH:mm:ss").format(dt);

  offset = offset ?? dt.timeZoneOffset;
  int minutes = (offset.inMinutes % 60);
  int hours = offset.inHours.toInt();

  String sign = '+';
  if (hours < 0) {
    hours = hours < 0 ? hours * -1 : hours;
    minutes = minutes < 0 ? minutes * -1 : minutes;
    sign = '-';
  }

  String hourStr;
  if (hours < 10) {
    hourStr = '0' + hours.toString();
  } else {
    hourStr = hours.toString();
  }

  String minutesStr;
  if (minutes < 10) {
    minutesStr = '0' + minutes.toString();
  } else {
    minutesStr = minutes.toString();
  }

  return result + sign + hourStr + ':' + minutesStr;
}

DateTime parseDateTime(String str) {
  DateTime dt;
  try {
    dt = DateTime.parse(str).toLocal();
  } catch (ex) {
    // Ignore it
  }

  if (dt == null) {
    var regex = RegExp(
        r"(\d{4})-(\d{2})-(\d{2})T(\d{2})\:(\d{2})\:(\d{2})\+(\d{2})\:(\d{2})");
    if (regex.hasMatch(str)) {
      // FIXME: Handle the timezone!
      str = str.substring(0, 19);
      dt = DateTime.parse(str);
    }
  }

  return dt;
}
