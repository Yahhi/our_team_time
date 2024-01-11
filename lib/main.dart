import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:our_team_time/core/storage/settings_storage.dart';
import 'package:our_team_time/model/time_item.dart';
import 'package:our_team_time/settings/settings_state.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics.instance;
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final settingsStorage = SettingsStorage();
  await settingsStorage.initialized;
  final settingsState = SettingsState(settingsStorage);
  GetIt.instance.registerSingleton(settingsState);
  LocationItem.localToUtcDifference = DateTime.now().timeZoneOffset.inHours;
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ru', 'RU'),
          Locale('es', 'ES')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        useOnlyLangCode: true,
        child: MyApp(settingsState)),
  );
}
