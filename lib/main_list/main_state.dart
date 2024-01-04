import 'dart:async';

import 'package:mobx/mobx.dart';

import '../core/storage/locations_db.dart';
import '../model/time_item.dart';

part 'main_state.g.dart';

class MainState = _MainState with _$MainState;

abstract class _MainState with Store {
  _MainState(this.db) : _nowTime = DateTime.now() {
    stickToNow();
    _fillItems();
  }

  final LocationsDb db;

  @observable
  ObservableList<LocationItem> items = ObservableList();

  @observable
  DateTime _nowTime;

  @computed
  DateTime get visibleTime => _customTime ?? _nowTime;

  @observable
  DateTime? _customTime;

  Timer? _nowUpdater;

  @action
  Future<void> _fillItems() async {
    await db.init();
    items.addAll(await db.loadLocations());
  }

  @action
  Future<void> addItem(LocationItem item) async {
    final itemWithId = await db.addLocation(item);
    items.add(itemWithId);
  }

  @action
  Future<void> updateItem(
      LocationItem oldItem, LocationItem updatedItem) async {
    await db.removeLocation(oldItem);
    final index = items.indexOf(oldItem);
    items.removeAt(index);
    final updatedWithId = await db.addLocation(updatedItem);
    items.insert(index, updatedWithId);
  }

  @action
  Future<void> deleteItem(LocationItem item) async {
    await db.removeLocation(item);
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
