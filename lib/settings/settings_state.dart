import 'dart:ui';

import 'package:mobx/mobx.dart';
import 'package:our_team_time/core/storage/settings_storage.dart';

part 'settings_state.g.dart';

class SettingsState = _SettingsState with _$SettingsState;

abstract class _SettingsState with Store {
  _SettingsState(this._settingsStorage)
      : timeIn24hours = _settingsStorage.hour24Setting,
        themeColor = Color(_settingsStorage.colorSetting);

  final SettingsStorage _settingsStorage;

  @observable
  bool timeIn24hours;

  @observable
  Color themeColor;

  @action
  void updateTimeSetting(bool time24) {
    _settingsStorage.hour24Setting = time24;
    timeIn24hours = time24;
  }

  @action
  void updateColorSetting(Color color) {
    _settingsStorage.colorSetting = color.value;
    themeColor = color;
  }
}
