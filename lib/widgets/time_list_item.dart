import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:our_team_time/main_list/main_state.dart';
import 'package:our_team_time/model/time_item.dart';
import 'package:our_team_time/model/time_view_format.dart';

class TimeListItem extends StatelessWidget {
  const TimeListItem({super.key, required this.data, required this.state});

  final TimeItem data;
  final MainState state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.cityName),
      trailing: Observer(builder: (context) {
        return Text(data.timeInFormat(TimeViewFormat.h24,
            requiredTime: state.visibleTime));
      }),
    );
  }
}
