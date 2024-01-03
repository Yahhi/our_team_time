import 'dart:math';

import 'package:flutter/material.dart';
import 'package:our_team_time/model/time_view_format.dart';
import 'package:timezone/timezone.dart';

class TimeItem {
  final String cityName;
  final String? personName;
  final Color color;
  final TimeZone timeZone;
  final TimeOfDay? workStart;
  final TimeOfDay? workEnd;

  static int? localToUtcDifference;

  TimeItem(
      {required this.cityName,
      this.personName,
      Color? customColor,
      required this.timeZone,
      this.workStart,
      this.workEnd})
      : color = customColor ?? _generateRandomColor();

  static Color _generateRandomColor() {
    var generatedColor = Random().nextInt(Colors.primaries.length);
    return Colors.primaries[generatedColor];
  }

  TimeOfDay timeInZone({DateTime? requiredTime}) {
    final time = requiredTime ?? DateTime.now();
    final local = time
        .add(Duration(hours: timeZone.offset - (localToUtcDifference ?? 0)));
    return TimeOfDay(hour: local.hour, minute: local.minute);
  }

  String timeInFormat(TimeViewFormat timeViewFormat, {DateTime? requiredTime}) {
    final time = timeInZone(requiredTime: requiredTime);
    switch (timeViewFormat) {
      case TimeViewFormat.h12:
        String periodIndicator = time.period == DayPeriod.am ? 'AM' : 'PM';
        return '${time.hourOfPeriod.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $periodIndicator';
      case TimeViewFormat.h24:
        return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }
}
