import 'package:flutter/material.dart';
import 'package:our_team_time/model/time_item.dart';
import 'package:our_team_time/model/time_view_format.dart';

class TimeListItem extends StatelessWidget {
  const TimeListItem({super.key, required this.data});

  final TimeItem data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.cityName),
      trailing: Text(data.timeInFormat(TimeViewFormat.h24)),
    );
  }
}
