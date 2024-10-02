import 'package:intl/intl.dart';

enum TimeType {
  today,
  month,
  year,
}

class TimeTool {
  static String timeStrByMs(int? ms) {
    if (ms == null) {
      return "";
    }

    DateTime date = DateTime.fromMillisecondsSinceEpoch(ms);
    String formattedTime = DateFormat('hh:mm a').format(date);

    return formattedTime;
  }

  static String timeDate(int? ms) {
    if (ms == null) {
      return "";
    }

    DateTime date = DateTime.fromMillisecondsSinceEpoch(ms);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    String today = DateFormat('yyyy-MM-dd').format(now);
    String yesterday = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 1)));

    if (formattedDate == today) {
      return "TODAY";
    } else if (formattedDate == yesterday) {
      return "YESTERDAY";
    } else {
      return formattedDate;
    }
  }


  static String durationStr(int duration) {
    if (duration <= 60) {
      return "${duration.toInt()}\"";
    } else if (duration > 60 && duration < 3600) {
      return "${(duration / 60).truncate().toInt()}'${(duration % 60).toInt()}\"";
    } else {
      return "${(duration / 3600).truncate().toInt()}h${(duration % 3600 / 60).truncate().toInt()}'${(duration % 3600 % 60).truncate().toInt()}\"";
    }
  }
}
