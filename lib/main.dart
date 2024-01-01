import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:our_team_time/main_list/main_page.dart';
import 'package:our_team_time/model/time_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TimeItem.localToUtcDifference = DateTime.now().timeZoneOffset.inHours;
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
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Timezones',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MainPage(),
    );
  }
}
