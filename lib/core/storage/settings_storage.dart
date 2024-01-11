import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  static const _hourSettingKey = 'hours';
  static const _colorSettingKey = 'color';

  late final SharedPreferences prefs;
  final _initFinished = Completer<bool>();
  Future<bool> get initialized => _initFinished.future;

  SettingsStorage() {
    SharedPreferences.getInstance().then((SharedPreferences prefInitialized) {
      prefs = prefInitialized;
      _hour24Setting = prefInitialized.getBool(_hourSettingKey);
      _colorSetting = prefInitialized.getInt(_colorSettingKey);
      _initFinished.complete(true);
    });
  }

  bool? _hour24Setting;
  bool get hour24Setting => _hour24Setting ?? true;
  set hour24Setting(bool value) {
    _hour24Setting = value;
    prefs.setBool(_hourSettingKey, value);
  }

  int? _colorSetting;
  int get colorSetting => _colorSetting ?? 0xFFFFFF;
  set colorSetting(int value) {
    _colorSetting = value;
    prefs.setInt(_colorSettingKey, value);
  }
}
