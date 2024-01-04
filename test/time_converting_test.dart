import 'package:flutter_test/flutter_test.dart';
import 'package:our_team_time/model/time_item.dart';
import 'package:our_team_time/model/time_view_format.dart';

import 'package:timezone/timezone.dart';

main() {
  test('utc time', () {
    final LocationItem item = LocationItem(
      id: 1,
      cityName: 'London',
      timeZone: const TimeZone(
        0,
        isDst: false,
        abbreviation: 'UTC',
      ),
    );
    expect(
        item.timeInFormat(TimeViewFormat.h24,
            requiredTime: DateTime(2000, 1, 1, 7, 20)),
        '07:20');
    expect(
        item.timeInFormat(TimeViewFormat.h24,
            requiredTime: DateTime(2000, 1, 1, 19, 20)),
        '19:20');
    expect(
        item.timeInFormat(TimeViewFormat.h24,
            requiredTime: DateTime(2000, 1, 1, 17, 5)),
        '17:05');
    expect(
        item.timeInFormat(TimeViewFormat.h12,
            requiredTime: DateTime(2000, 1, 1, 7, 20)),
        '07:20 AM');
    expect(
        item.timeInFormat(TimeViewFormat.h12,
            requiredTime: DateTime(2000, 1, 1, 20, 20)),
        '08:20 PM');
  });

  test('moscow time', () {
    final LocationItem item = LocationItem(
      id: 2,
      cityName: 'Moscow',
      timeZone: const TimeZone(
        3,
        isDst: false,
        abbreviation: 'UTC+3',
      ),
    );
    expect(
        item.timeInFormat(TimeViewFormat.h24,
            requiredTime: DateTime(2000, 1, 1, 6, 20)),
        '09:20');
    expect(
        item.timeInFormat(TimeViewFormat.h24,
            requiredTime: DateTime(2000, 1, 1, 19, 20)),
        '22:20');
    expect(
        item.timeInFormat(TimeViewFormat.h24,
            requiredTime: DateTime(2000, 1, 1, 17, 5)),
        '20:05');
    expect(
        item.timeInFormat(TimeViewFormat.h12,
            requiredTime: DateTime(2000, 1, 1, 7, 20)),
        '10:20 AM');
    expect(
        item.timeInFormat(TimeViewFormat.h12,
            requiredTime: DateTime(2000, 1, 1, 20, 20)),
        '11:20 PM');
    expect(
        item.timeInFormat(TimeViewFormat.h12,
            requiredTime: DateTime(2000, 1, 1, 21, 20)),
        '12:20 AM');
  });

  test('Buenos-Aires time', () {
    final LocationItem item = LocationItem(
      id: 3,
      cityName: 'Buenos Aires',
      timeZone: const TimeZone(
        -3,
        isDst: false,
        abbreviation: 'UTC-3',
      ),
    );
    expect(
        item.timeInFormat(TimeViewFormat.h24,
            requiredTime: DateTime(2000, 1, 1, 6, 20)),
        '03:20');
    expect(
        item.timeInFormat(TimeViewFormat.h24,
            requiredTime: DateTime(2000, 1, 1, 19, 20)),
        '16:20');
    expect(
        item.timeInFormat(TimeViewFormat.h24,
            requiredTime: DateTime(2000, 1, 1, 13, 5)),
        '10:05');
    expect(
        item.timeInFormat(TimeViewFormat.h12,
            requiredTime: DateTime(2000, 1, 1, 7, 20)),
        '04:20 AM');
    expect(
        item.timeInFormat(TimeViewFormat.h12,
            requiredTime: DateTime(2000, 1, 1, 20, 20)),
        '05:20 PM');
    expect(
        item.timeInFormat(TimeViewFormat.h12,
            requiredTime: DateTime(2000, 1, 1, 2, 20)),
        '11:20 PM');
  });
}
