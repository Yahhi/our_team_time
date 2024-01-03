import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:timezone/timezone.dart';

import '../model/time_item.dart';

part 'main_state.g.dart';

class MainState = _MainState with _$MainState;

abstract class _MainState with Store {
  _MainState() : _nowTime = DateTime.now() {
    stickToNow();
    _fillItems();
  }

  @observable
  ObservableList<TimeItem> items = ObservableList();

  @observable
  DateTime _nowTime;

  @computed
  DateTime get visibleTime => _customTime ?? _nowTime;

  @observable
  DateTime? _customTime;

  Timer? _nowUpdater;

  @action
  void _fillItems() {
    items.addAll([
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
    ]);
  }

  @action
  void addItem(TimeItem item) {
    items.add(item);
  }

  @action
  void updateItem(TimeItem oldItem, TimeItem updatedItem) {
    final index = items.indexOf(oldItem);
    items.removeAt(index);
    items.insert(index, updatedItem);
  }

  @action
  void deleteItem(TimeItem item) {
    items.remove(item);
  }

  @action
  void stickToNow() {
    _customTime = null;
    _startNowUpdater();
  }

  @action
  void _startNowUpdater() {
    _nowUpdater = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.minute != _nowTime.minute) {
        _nowTime = now;
      }
    });
  }

  @action
  void _stopNowUpdater() {
    _nowUpdater?.cancel();
    _nowUpdater = null;
  }

  @action
  void scrollCustomTime(int offset) {
    _stopNowUpdater();
    _customTime ??= DateTime.now();
    _customTime!.add(Duration(minutes: offset));
  }

  void dispose() {
    _stopNowUpdater();
  }
}
