enum TimeType {
  today,
  month,
  year,
}

class TimeTool {
  static TimeType _timeType(int ms) {
    DateTime now = DateTime.now();
    DateTime dateToCheck = DateTime.fromMillisecondsSinceEpoch(ms);
    if (now.year == dateToCheck.year) {
      if (now.month == dateToCheck.month) {
        if (now.day == dateToCheck.day) {
          return TimeType.today;
        } else {
          return TimeType.month;
        }
      } else {
        return TimeType.year;
      }
    } else {
      return TimeType.year;
    }
  }

  static String timeStrByMs(int? ms) {
    if (ms == null) {
      return "";
    }

    TimeType type = _timeType(ms);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(ms);
    String ret = "";
    switch (type) {
      case TimeType.today:
        ret =
            "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
        break;
      case TimeType.month:
        ret =
            "${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
        break;
      case TimeType.year:
        ret =
            "${date.year.toString()}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
        break;
    }
    return ret;
  }

  static String getMessageDate(int? ms, int? ms2) {
    if (ms == null || ms2 == null) {
      return "";
    }

    DateTime date = DateTime.fromMillisecondsSinceEpoch(ms);
    DateTime previousDate = DateTime.fromMillisecondsSinceEpoch(ms2);

    // Check if the date is different from the previous one
    if (date.year == previousDate.year &&
        date.month == previousDate.month &&
        date.day == previousDate.day) {
      return ""; // Return an empty string if the dates are the same
    }

    // Return only the date portion
    return "${date.year.toString()}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
  }


  static String getMessageDate1(int? ms, int? ms2) {
    if (ms == null || ms2 == null) {
      return "$ms- $ms2";
    }

    DateTime date1 = DateTime.fromMillisecondsSinceEpoch(ms);
    DateTime date2 = DateTime.fromMillisecondsSinceEpoch(ms2);
    return "{$date1-$date2}";

    // Check if the two dates are the same
    bool isSameDay = date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;

    // If it's the same day, return an empty string
    if (isSameDay) {
      return "";
    }

    // If the dates are different, return the formatted date for `ms`
    return "${date1.year.toString()}/${date1.month.toString().padLeft(2, '0')}/${date1.day.toString().padLeft(2, '0')}";
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
