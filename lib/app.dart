import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:our_team_time/settings/settings_state.dart';

import 'main_list/main_page.dart';

class MyApp extends StatelessWidget {
  final SettingsState settingsState;

  const MyApp(this.settingsState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        title: 'Team Timezones',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: settingsState.themeColor),
          useMaterial3: true,
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const MainPage(),
      ),
    );
  }
}
