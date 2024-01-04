import 'package:flutter/material.dart';
import 'package:our_team_time/model/person.dart';
import 'package:our_team_time/model/time_view_format.dart';
import 'package:timezone/timezone.dart';

class LocationItem {
  final int id;
  final String cityName;
  final List<Person> persons;
  final TimeZone timeZone;
  final double? latitude, longitude;

  static int? localToUtcDifference;

  LocationItem({
    required this.id,
    required this.cityName,
    List<Person>? people,
    required this.timeZone,
    this.latitude,
    this.longitude,
  }) : persons = people ?? [];

  LocationItem copyWithId(int id, List<Person> updatedPersons) => LocationItem(
      id: id,
      cityName: cityName,
      timeZone: timeZone,
      people: updatedPersons,
      latitude: latitude,
      longitude: longitude);

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

  bool equals(LocationItem updated) {
    return updated.cityName == cityName &&
        updated.longitude == longitude &&
        updated.latitude == latitude &&
        updated.timeZone == timeZone &&
        updated.persons == persons;
  }
}
