import 'package:timezone/timezone.dart';

import '../model/time_item.dart';

class MainState {
  List<TimeItem> items = [
    TimeItem(
      cityName: 'London',
      timeZone: const TimeZone(
        0,
        isDst: false,
        abbreviation: 'UTC',
      ),
    ),
    TimeItem(
      cityName: 'Moscow',
      timeZone: const TimeZone(
        3,
        isDst: false,
        abbreviation: 'UTC+3',
      ),
    ),
    TimeItem(
      cityName: 'Buenos Aires',
      timeZone: const TimeZone(
        -3,
        isDst: false,
        abbreviation: 'UTC-3',
      ),
    ),
  ];
}
