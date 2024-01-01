import 'package:flutter/material.dart';
import 'package:our_team_time/main_list/main_page.dart';
import 'package:our_team_time/model/time_item.dart';

void main() {
  runApp(const MyApp());
  TimeItem.localToUtcDifference = DateTime.now().timeZoneOffset.inHours;
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
      home: const MainPage(),
    );
  }
}
