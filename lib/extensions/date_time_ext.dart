extension DateTimeExt on DateTime {
  static DateTime? _mockedTime;

  static DateTime now() => _mockedTime ?? DateTime.now();

  static set mockTime(DateTime customTime) => _mockedTime = customTime;
  static void resetMockTime() => _mockedTime = null;

  DateTime toStartOfDay() => DateTime(year, month, day);

  DateTime nextWeekend() {
    int daysUntilSaturday = 6 - weekday;
    if (daysUntilSaturday < 1) {
      daysUntilSaturday += 7;
    }

    return add(Duration(days: daysUntilSaturday)).toStartOfDay();
  }

  String toDateString() {
    final String y =
        (year >= -9999 && year <= 9999) ? _fourDigits(year) : _sixDigits(year);
    final String m = _twoDigits(month);
    final String d = _twoDigits(day);

    return '$y-$m-$d';
  }

  String toFullIso8601String() {
    final String y =
        (year >= -9999 && year <= 9999) ? _fourDigits(year) : _sixDigits(year);
    final String m = _twoDigits(month);
    final String d = _twoDigits(day);
    final String h = _twoDigits(hour);
    final String min = _twoDigits(minute);
    final String sec = _twoDigits(second);
    final String ms = _threeDigits(millisecond);
    final String us = _threeDigits(microsecond);
    if (isUtc) {
      return '$y-$m-${d}T$h:$min:$sec.$ms${us}Z';
    } else {
      return '$y-$m-${d}T$h:$min:$sec.$ms$us';
    }
  }

  static String _fourDigits(int n) {
    final int absN = n.abs();
    final String sign = n < 0 ? '-' : '';
    if (absN >= 1000) return '$n';
    if (absN >= 100) return '${sign}0$absN';
    if (absN >= 10) return '${sign}00$absN';
    return '${sign}000$absN';
  }

  static String _sixDigits(int n) {
    assert(n < -9999 || n > 9999, 'Invalid');
    final int absN = n.abs();
    final String sign = n < 0 ? '-' : '+';
    if (absN >= 100000) return '$sign$absN';
    return '${sign}0$absN';
  }

  static String _threeDigits(int n) {
    if (n >= 100) return '$n';
    if (n >= 10) return '0$n';
    return '00$n';
  }

  static String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}
